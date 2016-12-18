#ifndef __VIEW_H__
#define __VIEW_H__
#include <QWidget>

Q_FORWARD_DECLARE_OBJC_CLASS(UITextView);

class View : public QWidget
{
  Q_OBJECT
  
public:
  
  View(QWidget* parent=0);
  ~View();
protected:
  virtual bool event(QEvent*);
private:
  UITextView* m_TextView;
  bool m_scheduled;
private slots:
  void updateGeo();
};

#endif
