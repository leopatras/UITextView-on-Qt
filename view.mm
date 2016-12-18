#include "view.h"
#include <QEvent>
#include <QTimer>
#include <QRect>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
View::View(QWidget* parent):QWidget(parent)
{
  m_TextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  QWidget* w= window();
  UIView *parentView = reinterpret_cast<UIView *>(w->winId());
  [parentView addSubview:m_TextView];
}

View::~View()
{
  [m_TextView removeFromSuperview];
  m_TextView=nil;
}

bool View::event(QEvent* e)
{
  if (e->type()==QEvent::Move || e->type()==QEvent::Resize) {
    if (!m_scheduled) {
      m_scheduled=true;
      QTimer::singleShot( 0, this, SLOT( updateGeo() ) );
    }
  }
  bool result=QWidget::event(e);
  return result;
}

QRect globalRect(QWidget* w,const QRect& r)
{
  QPoint topLeft = w->mapToGlobal( r.topLeft() );
  QPoint bottomRight = w->mapToGlobal( r.bottomRight() );
  return QRect(topLeft,bottomRight);
}

void View::updateGeo()
{
  m_scheduled=false;
  QRect rg=globalRect(this,rect());
  QRect rw=globalRect(window(),window()->rect());
  CGRect cg=CGRectMake(rg.x(), rg.y()-rw.y(), rg.width(), rg.height());
  [m_TextView setFrame:cg];
}
