import pymssql
import kivy
import networkx as nx
import pylab as plt
from networkx.drawing.nx_agraph import graphviz_layout, to_agraph
import pygraphviz as pgv
from kivy.app import App
from kivy.uix.label import Label
from kivy.uix.gridlayout import GridLayout
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.widget import Widget
from kivy.properties import StringProperty
from kivy.properties import ObjectProperty
from struct import pack
from kivy.uix.popup import Popup
from kivy.uix.gridlayout import GridLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.uix.scrollview import ScrollView
from kivy.graphics import Rectangle
from kivy.graphics import Color
from kivy.uix.widget import Widget
from kivy.graphics import Line
import time



SERVER = "localhost"
USER = "sa"
PASSWORD = "yourPassword"
DATABASE = "DB_FinalProject"

connection = pymssql.connect(server=SERVER, user=USER,
                password=PASSWORD, database=DATABASE)

cursor = connection.cursor()
cursor.execute("SELECT * FROM myOutput order by RowNumber")

products = []
i = 0

SourceDep = ""

for row in cursor:
    src = str(row[4])
    dest = str(row[5])

class ScrollableLabel(ScrollView):
    text = StringProperty('')
    pass

class EScrollableLabel(ScrollView):
    text = StringProperty('')
    pass

class EEScrollableLabel(ScrollView):
    text = StringProperty('')
    pass

class MyGrid(GridLayout,Screen):
    def __init__(self, **kwargs):
        super(MyGrid, self).__init__(**kwargs)
        self.cols = 1
        self.inside = GridLayout()
        self.inside.cols = 1

        self.add_widget(Label(text='             Welcome\nPlease select an option:',color =(.79, .78, .27, 1),font_size = '40dp'))

        self.btn = Button(text="Check the validity of the customer national code",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedNextPage)
        self.add_widget(self.btn)

        self.btn = Button(text="View all transactions in this bank",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedNext3Page)
        self.add_widget(self.btn)

        self.btn = Button(text="Add a new transaction",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedNext4Page)
        self.add_widget(self.btn)

        self.btn = Button(text="Find the source and destination of a transaction",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedNext2Page)
        self.add_widget(self.btn)

        self.btn = Button(text="Graph",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedNext5Page)
        self.add_widget(self.btn)

    def pressedNextPage(self, instance):
        self.manager.current = 'nextScreen'

    def pressedNext2Page(self, instance):
        self.manager.current = 'nextScreenPage3'

    def pressedNext3Page(self, instance):
        self.manager.current = 'nextScreenPage4'

    def pressedNext4Page(self, instance):
        self.manager.current = 'nextScreenPage5'

    def pressedNext5Page(self, instance):
        self.manager.current = 'nextScreenPage6'

class nextScreen(GridLayout,Screen):
    def __init__(self, **kwargs):
        super(nextScreen, self).__init__(**kwargs)

        self.cols = 1
        self.inside = GridLayout(cols=2)
        self.inside.cols = 1

        self.GetTransaction = "select * from vCustomer"
        cursor.execute(self.GetTransaction)

        CustomerList = "\nName                                        NatCod                                Tel                     Validity\n\n"
        for row in cursor:
            CustomerList += (str(row[0]).ljust(50-len(str(row[0])))+str(row[1]).ljust(40-len(str(row[1])))+str(row[2]).ljust(40-len(str(row[2])))+str(row[3])+'\n')


        self.add_widget(ScrollableLabel(text=CustomerList,color =(.79, .78, .27, 1)))

        self.btn = Button(text="Back",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedMainPage)
        self.add_widget(self.btn)


    def pressedMainPage(self, instance):
        self.manager.current = 'MyGrid'

class nextScreenPage3(GridLayout,Screen):
    def __init__(self, **kwargs):
        super(nextScreenPage3, self).__init__(**kwargs)
        self.cols = 1
        self.inside = GridLayout()
        self.inside.cols = 1

        self.Lbl = Label(text='Please enter the VoucherID',color =(.79, .78, .27, 1),font_size = '25dp')
        self.add_widget(self.Lbl)
        self.VoucherID = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.VoucherID)

        self.btn1 = Button(text="Accept",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn1.bind(on_press=self.pressedAccept)
        self.add_widget(self.btn1)

        self.btn = Button(text="Back",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedMainPage)
        self.add_widget(self.btn)


    def pressedMainPage(self, instance):
        #self.remove_widget(self.lbl2)
        #self.remove_widget(self.lbl3)
        self.manager.current = 'MyGrid'

    def pressedAccept(self, instance):
        if self.VoucherID.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="VoucherID field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        else:
            myVoucherID = self.VoucherID.text

            self.DeletefromMyOutput = "delete from myOutput"
            cursor.execute(self.DeletefromMyOutput)
            connection.commit()

            self.DeletefromMyOutputLEFT = "delete from myOutputLEFT"
            cursor.execute(self.DeletefromMyOutputLEFT)
            connection.commit()

            self.DeleteFromTr = "delete from tr"
            cursor.execute(self.DeleteFromTr)
            connection.commit()

            self.DeletetempTableOfTrans = "delete from tempTableOfTrans"
            cursor.execute(self.DeletetempTableOfTrans)
            connection.commit()

            self.INSERTtempTableOfTrans = '''insert into tempTableOfTrans
                                            select *, ROW_NUMBER() over (order by TrnDate, TrnTime)
                                            from Trn_Src_Des'''
            cursor.execute(self.INSERTtempTableOfTrans)
            connection.commit()

            self.GetTransaction = "EXECUTE BankingTransactions " + str(myVoucherID)
            cursor.execute(self.GetTransaction)
            connection.commit()


            self.GetLeftSide = "select * from myOutputLEFT"
            cursor.execute(self.GetLeftSide)

            Transaction1 = " Left Side:\n\n  VoucherID        TrnDate             TrnTime    Amount     SourceDep       DesDep        BranchID          RowNumber                Trn_Desc\n"
            for row in cursor:
                Transaction1 += (str(row[0]).ljust(24-len(str(row[0])))+"   "+str(row[1]).ljust(24-len(str(row[1])))+"    "+str(row[2]).ljust(6-len(str(row[2])))+"         "+str(row[3]).ljust(6-len(str(row[3])))+"                 "+str(row[4]).ljust(6-len(str(row[4])))+"                  "+str(row[5]).ljust(6-len(str(row[5])))+"                  "+str(row[6]).ljust(7-len(str(row[6])))+"                      "+str(row[8]).ljust(7-len(str(row[8])))+"                "+str(row[7])+'\n')


            self.GetrightSide = "select * from myOutput"
            cursor.execute(self.GetrightSide)

            Transaction2 = " Right Side:\n\n  VoucherID        TrnDate             TrnTime    Amount     SourceDep       DesDep        BranchID          RowNumber                Trn_Desc\n"
            for row in cursor:
                Transaction2 += (str(row[0]).ljust(24-len(str(row[0])))+"   "+str(row[1]).ljust(24-len(str(row[1])))+"    "+str(row[2]).ljust(6-len(str(row[2])))+"         "+str(row[3]).ljust(6-len(str(row[3])))+"                 "+str(row[4]).ljust(6-len(str(row[4])))+"                  "+str(row[5]).ljust(6-len(str(row[5])))+"                  "+str(row[6]).ljust(7-len(str(row[6])))+"                      "+str(row[8]).ljust(7-len(str(row[8])))+"                "+str(row[7])+'\n')



            self.remove_widget(self.btn1)
            self.remove_widget(self.VoucherID)
            self.remove_widget(self.Lbl)

            self.lbl2 = EScrollableLabel(text=Transaction1,color =(.79, .78, .27, 1))
            self.add_widget(self.lbl2)
            self.lbl3 = EScrollableLabel(text=Transaction2,color =(.79, .78, .27, 1))
            self.add_widget(self.lbl3)

            self.DeleteLeftSide = "delete from myOutputLEFT"
            cursor.execute(self.DeleteLeftSide)
            connection.commit()

            self.DeleteRightSide = "delete from myOutput"
            cursor.execute(self.DeleteRightSide)
            connection.commit()

            self.Deletetr = "delete from tr"
            cursor.execute(self.Deletetr)
            connection.commit()

class nextScreenPage4(GridLayout,Screen):
    def __init__(self, **kwargs):
        super(nextScreenPage4, self).__init__(**kwargs)

        self.cols = 1
        self.inside = GridLayout(cols=2)
        self.inside.cols = 1

        self.GetTransaction = "select * from Trn_Src_Des"
        cursor.execute(self.GetTransaction)

        ALLTransaction = " All transactions:\n\n  VoucherID        TrnDate             TrnTime    Amount     SourceDep       DesDep        BranchID                Trn_Desc\n"
        for row in cursor:
            ALLTransaction += (str(row[0]).ljust(24-len(str(row[0])))+"   "+str(row[1]).ljust(24-len(str(row[1])))+"    "+str(row[2]).ljust(6-len(str(row[2])))+"         "+str(row[3]).ljust(6-len(str(row[3])))+"                 "+str(row[4]).ljust(6-len(str(row[4])))+"                  "+str(row[5]).ljust(6-len(str(row[5])))+"                  "+str(row[6]).ljust(7-len(str(row[6])))+"                "+str(row[7])+'\n')


        self.add_widget(EEScrollableLabel(text=ALLTransaction,color =(.79, .78, .27, 1)))

        self.btn = Button(text="Back",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedMainPage)
        self.add_widget(self.btn)


    def pressedMainPage(self, instance):
        self.manager.current = 'MyGrid'


class nextScreenPage5(GridLayout,Screen):
    def __init__(self, **kwargs):
        super(nextScreenPage5, self).__init__(**kwargs)
        self.cols = 2
        self.inside = GridLayout()
        self.inside.cols = 1

        self.Lbl = Label(text='VoucherID:',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.VoucherID = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.VoucherID)

        self.Lbl = Label(text='Date:',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.TrnDate = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.TrnDate)

        self.Lbl = Label(text='Transaction Time:',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.TrnTime = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.TrnTime)

        self.Lbl = Label(text='Amount:',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.Amount = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.Amount)

        self.Lbl = Label(text='Source ID:',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.Source = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.Source)

        self.Lbl = Label(text='Destination ID:',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.Destination = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.Destination)

        self.Lbl = Label(text='Branch ID',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.Branch = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.Branch)

        self.Lbl = Label(text='Description:',color =(.79, .78, .27, 1),font_size = '15dp')
        self.add_widget(self.Lbl)
        self.Description = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.Description)

        self.btn1 = Button(text="Accept",background_color =(.79, .78, .27, .5),halign="left",font_size = '15dp',color =(1, 1, 1, .8))
        self.btn1.bind(on_press=self.pressedAccept)
        self.add_widget(self.btn1)

        self.btn = Button(text="Back",background_color =(.79, .78, .27, .5),halign="left",font_size = '15dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedMainPage)
        self.add_widget(self.btn)

    def pressedMainPage(self, instance):
        self.manager.current = 'MyGrid'

    def pressedAccept(self, instance):
        if self.VoucherID.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="VoucherID field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        elif self.TrnDate.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="Date field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        elif self.TrnTime.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="Time field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        elif self.Amount.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="Amount field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        elif self.Source.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="SourceID field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        elif self.Destination.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="DestinationID field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        elif self.Branch.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="Branch field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        elif self.Description.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="Description field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        else:

            itVoucherID = self.VoucherID.text
            itTrnTime = self.TrnTime.text
            itTrnDate = self.TrnDate.text
            itAmount = self.Amount.text
            itSourceID = self.Source.text
            itDestinationID = self.Destination.text
            itBranchID = self.Branch.text
            itDescription = self.Description.text

            self.InsertIntoTransaction = "INSERT INTO Trn_Src_Des VALUES ('" + itVoucherID + "','" + itTrnDate + "','" + itTrnTime + "'," + itAmount + "," + itSourceID + "," + itDestinationID + "," + itBranchID + ",'" + itDescription + "')"
            cursor.execute(self.InsertIntoTransaction)
            connection.commit()

            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="DONE!",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)

            self.VoucherID.text = ""
            self.TrnTime.text = ""
            self.TrnDate.text = ""
            self.Source.text = ""
            self.Destination.text = ""
            self.Amount.text = ""
            self.Branch.text = ""
            self.Description.text = ""

class nextScreenPage6(GridLayout,Screen):
    def __init__(self, **kwargs):
        super(nextScreenPage6, self).__init__(**kwargs)
        self.cols = 2
        self.inside = GridLayout()
        self.inside.cols = 1


        self.Lbl = Label(text='Please enter the VoucherID',color =(.79, .78, .27, 1),font_size = '25dp')
        self.add_widget(self.Lbl)
        self.VoucherID = TextInput(multiline=False,background_color=(.79, .78, .27, .4),halign="center")
        self.add_widget(self.VoucherID)

        self.btn1 = Button(text="Show the Graph",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn1.bind(on_press=self.pressedGraph)
        self.add_widget(self.btn1)

        self.btn = Button(text="Back",background_color =(.79, .78, .27, .5),halign="left",font_size = '25dp',color =(1, 1, 1, .8))
        self.btn.bind(on_press=self.pressedMainPage)
        self.add_widget(self.btn)


    def pressedMainPage(self, instance):
        self.manager.current = 'MyGrid'


    def pressedGraph(self, instance):
        if self.VoucherID.text == "":
            layout = GridLayout(cols = 1, padding = 50)
            closeButton = Button(text = "Close")
            layout.add_widget(closeButton)
            popup = Popup(title ="VoucherID field is empty",content = layout,size_hint =(None, None), size =(500, 500))
            popup.open()
            closeButton.bind(on_press = popup.dismiss)
        else:
            myVoucherID = self.VoucherID.text

            self.GetCenterOfGraph = "select * from Trn_Src_Des where VoucherId = " + myVoucherID
            cursor.execute(self.GetCenterOfGraph)

            for row in cursor:
                Source = row[4]
                Dest = row[5]

            self.DeletefromMyOutput = "delete from myOutput"
            cursor.execute(self.DeletefromMyOutput)
            connection.commit()

            self.DeletefromMyOutputLEFT = "delete from myOutputLEFT"
            cursor.execute(self.DeletefromMyOutputLEFT)
            connection.commit()

            self.DeleteFromTr = "delete from tr"
            cursor.execute(self.DeleteFromTr)
            connection.commit()

            self.DeletetempTableOfTrans = "delete from tempTableOfTrans"
            cursor.execute(self.DeletetempTableOfTrans)
            connection.commit()

            self.INSERTtempTableOfTrans = '''insert into tempTableOfTrans
                                            select *, ROW_NUMBER() over (order by TrnDate, TrnTime)
                                            from Trn_Src_Des'''
            cursor.execute(self.INSERTtempTableOfTrans)
            connection.commit()

            self.GetTransaction = "EXECUTE BankingTransactions " + str(myVoucherID)
            cursor.execute(self.GetTransaction)
            connection.commit()


            myGraph = nx.DiGraph()
            myGraph.add_node(Source)
            myGraph.add_node(Dest)

            myGraph.add_edges_from([(Source,Dest)])

            LabelForEdges = dict()

            LabelForEdges[(Source,Dest)] = str(row[3]) + '\n' + str(row[2]) + '\n' + str(row[1])

            #rightSide
            self.GetRight = "select * from myOutput where SourceDep = " + str(Dest)
            cursor.execute(self.GetRight)

            myDests = []
            TempMyDests = []
            date = []
            time = []
            amount = []

            for row in cursor:
                myDests.append(row[5])
                amount.append(row[3])
                time.append(row[2])
                date.append(row[1])

            for i in range (0,len(myDests)):
                myGraph.add_node(myDests[0])
                myGraph.add_edges_from([(Dest,myDests[0])])
                LabelForEdges[(Dest,myDests[0])] = str(amount[0]) + '\n' + str(time[0]) + '\n' + str(date[0])
                TempMyDests.append(myDests[0])
                myDests.pop(0)
                amount.pop(0)
                time.pop(0)
                date.pop(0)


            while (1):
                if len(TempMyDests) == 0:
                    break

                NewDest = TempMyDests.pop(0)

                self.GetRight = "select * from myOutput where SourceDep = " + str(NewDest)
                cursor.execute(self.GetRight)

                for row in cursor:
                    myDests.append(row[5])
                    amount.append(row[3])
                    time.append(row[2])
                    date.append(row[1])

                for i in range (0,len(myDests)):
                    myGraph.add_node(myDests[0])
                    myGraph.add_edges_from([(NewDest,myDests[0])])
                    LabelForEdges[(NewDest,myDests[0])] = str(amount[0]) + '\n' + str(time[0]) + '\n' + str(date[0])
                    TempMyDests.append(myDests[0])
                    myDests.pop(0)
                    amount.pop(0)
                    time.pop(0)
                    date.pop(0)



            #LeftSide
            self.GetRight = "select * from myOutputLEFT where DesDep = " + str(Source)
            cursor.execute(self.GetRight)

            LEFTmyDests = []
            LEFTTempMyDests = []
            LEFTdate = []
            LEFTtime = []
            LEFTamount = []

            for row in cursor:
                LEFTmyDests.append(row[4])
                LEFTamount.append(row[3])
                LEFTtime.append(row[2])
                LEFTdate.append(row[1])

            for i in range (0,len(LEFTmyDests)):
                myGraph.add_node(str(LEFTmyDests[0])+'L')
                forEdge = str(LEFTmyDests[0])+'L'
                myGraph.add_edges_from([(str(LEFTmyDests[0])+'L',Source)])
                LabelForEdges[(forEdge,Source)] = str(LEFTamount[0]) + '\n' + str(LEFTtime[0]) + '\n' + str(LEFTdate[0])
                LEFTTempMyDests.append(str(LEFTmyDests[0]))
                LEFTmyDests.pop(0)
                LEFTdate.pop(0)
                LEFTtime.pop(0)
                LEFTamount.pop(0)

            while (1):
                LEFTNewDest = LEFTTempMyDests.pop(0)

                self.GetRight = "select * from myOutputLEFT where DesDep = " + str(LEFTNewDest)
                cursor.execute(self.GetRight)

                for row in cursor:
                    LEFTmyDests.append(row[4])
                    LEFTamount.append(row[3])
                    LEFTtime.append(row[2])
                    LEFTdate.append(row[1])

                for i in range (0,len(LEFTmyDests)):
                    myGraph.add_node(str(LEFTmyDests[0])+'L')
                    forEdge = str(LEFTmyDests[0])+'L'
                    myGraph.add_edges_from([(str(LEFTmyDests[0])+'L',LEFTNewDest+'L')])
                    forEdge2 = LEFTNewDest+'L'
                    LabelForEdges[(forEdge,forEdge2)] = str(LEFTamount[0]) + '\n' + str(LEFTtime[0]) + '\n' + str(LEFTdate[0])
                    LEFTTempMyDests.append(str(LEFTmyDests[0]))
                    LEFTmyDests.pop(0)
                    LEFTdate.pop(0)
                    LEFTtime.pop(0)
                    LEFTamount.pop(0)

                if len(LEFTTempMyDests) == 0:
                    break


            myPos = graphviz_layout(myGraph, prog='dot', args="-Grankdir=LR")
            nx.draw(myGraph, myPos, font_size=9, edge_color='black', width=1, linewidths=1,
                    node_size=400, node_color='#805500', cmap=plt.cm.Blues,with_labels=True,
                            prog='dot', labels={node: node for node in myGraph.nodes()})


            nx.draw_networkx_edge_labels(myGraph, myPos, font_size=8, font_color='#5e5c42', edge_labels=LabelForEdges)

            plt.show()



            self.DeleteLeftSide = "delete from myOutputLEFT"
            cursor.execute(self.DeleteLeftSide)
            connection.commit()

            self.DeleteRightSide = "delete from myOutput"
            cursor.execute(self.DeleteRightSide)
            connection.commit()

            self.Deletetr = "delete from tr"
            cursor.execute(self.Deletetr)
            connection.commit()


class MyApp(App):
    def build(self):
        sm = ScreenManager()
        sm.add_widget(MyGrid(name='MyGrid'))
        sm.add_widget(nextScreen(name='nextScreen'))
        sm.add_widget(nextScreenPage3(name='nextScreenPage3'))
        sm.add_widget(nextScreenPage4(name='nextScreenPage4'))
        sm.add_widget(nextScreenPage5(name='nextScreenPage5'))
        sm.add_widget(nextScreenPage6(name='nextScreenPage6'))
        return sm
        return MyGrid()



if __name__ == "__main__":
    MyApp().run()
