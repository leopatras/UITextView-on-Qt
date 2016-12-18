#include "view.h"
#include <QEvent>
#include <QTimer>
#include <QRect>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
View::View(QWidget* parent):QWidget(parent),m_scheduled(false)
{
  m_TextView=[[UITextView alloc] init];
  UIView *parentView = reinterpret_cast<UIView *>(window()->winId());
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

static inline QRect globalRect(QWidget* widget)
{
  return QRect((widget)->mapToGlobal(QPoint(0,0)), (widget)->size());
}

void View::updateGeo()
{
  m_scheduled=false;
  QRect rg=globalRect(this);
  QRect rw=globalRect(window());
  CGRect cg=CGRectMake(rg.x(), rg.y()-rw.y(), rg.width(), rg.height());
  [m_TextView setFrame:cg];
}
