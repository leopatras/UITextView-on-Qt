#include "main.h"
#include "view.h"
#include <QApplication>
#include <QVBoxLayout>
#include <QPushButton>
#include <QLineEdit>


MainWindow::MainWindow() : QMainWindow()
{
    QWidget *central = new QWidget(this);
    QVBoxLayout *mainLayout = new QVBoxLayout;
    QPushButton* pushb=new QPushButton(central);
    pushb->setText("hallo");
    mainLayout->addWidget(pushb);
    connect(pushb, SIGNAL(clicked()), qApp, SLOT(quit()));
    //QTextEdit* te=new QTextEdit(central);
    //mainLayout->addWidget(te);
    QFrame* f=new MyFrame(central);
    f->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    mainLayout->addWidget(f);
    QLineEdit* e2=new QLineEdit(central);
    mainLayout->addWidget(e2);
  
    central->setLayout(mainLayout);
    setCentralWidget(central);
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    MainWindow mainWin;
    mainWin.show();
    return app.exec();
}
