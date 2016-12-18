#ifndef __VIEW_H__
#define __VIEW_H__
#include <QFrame>

Q_FORWARD_DECLARE_OBJC_CLASS(UITextView);

class MyFrame : public QFrame
{
  Q_OBJECT
  
public:
  
  MyFrame(QWidget* parent=0);
  ~MyFrame();
protected:
  virtual bool event(QEvent*);
private:
  UITextView* m_TextView;
  bool m_scheduled;
private slots:
  void updateGeo();
};

#endif
