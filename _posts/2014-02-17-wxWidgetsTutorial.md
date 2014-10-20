---
layout: post
title: WxWidgets Tutorial
---

## Introduction

*wxWidgets* is a cross-platform C++ GUI toolkit which provides  an easy and fast way to implement GUI of any complexity.
 In this tutorial we will compile *wxWidgets* under Linux and write simple GUI application.


## Compiling wxWidgets

First, make sure you have GTK development files:
{% highlight bash %}
$sudo apt-get install libgtk2.0-dev
{% endhighlight %}

Next, download wxGTK source and extract the files somewere. After you have extracted the files:

{% highlight bash linenos %}
$cd path/to/wxGTK
$mkdir build-gtk
$cd build-gtk
{% endhighlight %}

We have created the build directory from where we will build wxWidgets binaries.
Next, type this to configure:

{% highlight bash %}
$../configure
{% endhighlight %}

And then:
{% highlight bash %}
$make
{% endhighlight %}

After the compilation you can install wxWidgets with:

{% highlight bash %}
$make install
{% endhighlight %}

Writing a simple demo

Our next step is to write simple demo to demonstrate the power of wxWidgets library.
We wll create a window with toolbar, menu and a few tabs with different things inside.
I will guide you step by step and eventually you can grab the source code for this
tutorial from it`s Github [repository](https://github.com/RostakaGmfun/wxWidgetsTutorial).


## Creating an application and window


Every wxWidgets application is represented as a class derived from `wxApp`.  So we will declare our `App` class derived from `wxApp` in `app.h` file:

{% highlight cpp linenos %}
    #include <wx/app.h>

    class App : public wxApp
    {
        public:
            virtual bool OnInit();
    };
{%endhighlight %}
Here we declare a single method OnInit() which will be called once our application starts. In this method we will create our window. The actual application entry point and implementation is defined as IMPLEMENT_APP macro which we place in our app.cpp file:
{% highlight cpp linenos %}
 #include "app.h"

IMPLEMENT_APP(App);
{%endhighlight %}

Our App::OnInit() is empty for now:
{% highlight cpp linenos %}
bool App::OnInit()
{

    return true;
}
{%endhighlight %}

Now it is time to create the window. Our  window class is called Frame and is derived from wxFrame. I placed Frame declaration and definition in main.h and main.cpp respectively. I called those two files as main because the main code is here.

{% highlight cpp linenos %}
#include <wx/wx.h>

class Frame: public wxFrame //our Frame class derives from wxFrame base class
{
    public:
        Frame(wxFrame *frame, const wxString& title);
        ~Frame();
{%endhighlight %}

We have an constructor which takes as parameters a pointer to the parent window(if any) and a title string. Next look at the constructor definition:

{% highlight cpp linenos %}
Frame::Frame(wxFrame *frame, const wxString& title) //in our constructor we call wxFrame constructor to create a window
    : wxFrame(frame, -1, title, wxPoint(100,100),wxDefaultSize,wxMINIMIZE_BOX | wxSYSTEM_MENU | wxCAPTION | wxCLOSE_BOX)
{
    SetSize(1024,768); //set the size
}
{%endhighlight %}

In our constructor we call `wxFrame` constructor to actually create the window at screen coordinates `(100;100).
We also call `wxFrame` member function `SetSize()` to set the window size
(you also can specify window size in constructor by writing `wxPoint(1024,768)` instead of `wxDefaultSize`).
To show our window we should include `main.h` file in `app.cpp` and modify our `App::OnInit()` function:

{% highlight cpp linenos %}
bool App::OnInit()
{
    Frame* frame = new Frame(0L, "Awesome Programmer wxWidgets Tutorial");

    frame->Show();

    return true;
}
{%endhighlight %}

We call wxFrame::Show() to show our window.

## Adding menu and toolbar

It is time to add menu to our window. In `main.h`:

{% highlight cpp linenos %}
class Frame: public wxFrame
{
    private:
        wxMenuBar* menuBar;
 wxMenu* menuFile;
 wxMenu* menuAbout;
}
{%endhighlight %}

And in `main.cpp`:

{% highlight cpp linenos %}
Frame::Frame(wxFrame *frame, const wxString& title)
    : wxFrame(frame, -1, title, wxPoint(100,100),wxDefaultSize,wxMINIMIZE_BOX | wxSYSTEM_MENU | wxCAPTION | wxCLOSE_BOX)
{
       SetSize(1024,768); //set the size
       menuBar = new wxMenuBar;
       menuFile = new wxMenu;
       menuAbout = new wxMenu;
       menuPaint = new wxMenu;

       //append menu entries for our 'File' and 'About' menus
       //we use the same event IDs as in EVT_MENU macro (see above)
       menuFile->Append(NEW,"&New");
       menuFile->Append(OPEN,"&Open");
       menuFile->Append(SAVE,"&Save");
       menuFile->Append(QUIT,"&Quit");

      menuAbout->Append(ABOUT,"&About");

 //append menus to the menubar
 menuBar->Append(menuFile,"&File");
 menuBar->Append(menuAbout,"&Help");

 //show our menu bar
 SetMenuBar(menuBar);
}
{%endhighlight %}

A little explanation is needed here. First, we create our objects.
The we use `wxMenu::Append()` function to add menu entry.
`wxMenu::Append()` function takes as parameter an `ID` of event to be handled when the users selects that entry(see below) and a text to display.
Finally we append our menus to the menu bar with `wxMenuBar::Append() function and set up the menu bar for our window with `SetMenuBar() function.

And now let's add some response to our menu. First of all, place a call to `DECLARE_EVENT_TABLE()` macro in our `Frame` class definition.
 We will define so-called event table later. We will specify the event handler - the callback function which will be called on particular event.
  First, we will create an event handler for `About` menu. So place the following private function declaration in our `Frame` class:

    void OnAbout(wxCommandEvent& event);

Next, add function's definition in `main.cpp`:

{% highlight cpp linenos %}
void Frame::OnAbout(wxCommandEvent &event)
{
    wxMessageBox("This is simple wxWidgets tutorial from awesomeproger.blogspot.com", "Awesome Programmer tutorial");
}
{%endhighlight %}

Every event handler in wxWidgets must have it's own `ID`. It is possible to use predefined `ID`s, but we will declare our own as enumeration:

{% highlight cpp linenos %}
enum ev_ids
{
    QUIT,
    ABOUT,
    OPEN,
    SAVE,
    NEW,
};
{%endhighlight %}

We will add more IDs later to have more functionality.
To actually specify this function as event handler we need to add the following code somewhere in `main.cpp`:

{% highlight cpp linenos %}
BEGIN_EVENT_TABLE(Frame, wxFrame) //we begin declaring event table by specifying the class we want to declare event table for and it's base class
    //we use EVT_MENU macro for menu entries. Here we pas a custom defined event id which we will use later to create appropriate controls
    EVT_MENU(ABOUT, Frame::OnAbout)
END_EVENT_TABLE()
{%endhighlight %}

`EVT_MENU` macro specifies a menu event. It takes as parameters and event `ID` and an event handler function.

Next, try adding a `QUIT` event, use `Close()` function to close the window.

Now it is time to create a toolbar which will duplicate the functionality of menu bar. Add a private pointer to `wxToolBar` in our
`Frame` class and use the following code to create toolbar:

{% highlight cpp linenos %}
    toolBar = CreateToolBar();

    //we use wxArtProvider class (from wx/artprov.h) to get the default icons into our bitmaps
    wxBitmap open = wxArtProvider::GetBitmap(wxART_FILE_OPEN,wxART_TOOLBAR);
    wxBitmap exit = wxArtProvider::GetBitmap(wxART_QUIT,wxART_TOOLBAR);
    wxBitmap save = wxArtProvider::GetBitmap(wxART_FILE_SAVE, wxART_TOOLBAR);
    wxBitmap b_new = wxArtProvider::GetBitmap(wxART_NEW,wxART_TOOLBAR);

    toolBar->AddTool(NEW, b_new, "New file");
    toolBar->AddTool(OPEN, open, "Open file");
    toolBar->AddTool(SAVE, save, "Save file");
    toolBar->AddTool(QUIT, exit, "Exit");

    //show our toolbar. It needs to be called every time the toolbar has been modified
    toolBar->Realize();
{%endhighlight %}

We used function `CreateToolBar()` to create toolbar and `wxToolBar::AddTool()` to add buttons to it.
The `AddTool()` functions takes as parameters corresponding event `ID`, bitmap image for the button(see below)
 and a text to display when the mouse hovers on button.
 To create bitmaps for our images we used `wxArtProviderClass` instead of manually loading custom images from disk.
 The `wxArtProvider::GetBitmap()` returns the `wxBitmap` for us.
 There is a number of predefined values for first parameter of the function and the second parameter tells that we want toolbar bitmap.
 The complete list of bitmap IDs can be found in `wxWidgets` [documentation](http://docs.wxwidgets.org/trunk/classwx_art_provider.html).
 Finally, the `wxToolBar::Realize()` functions shows our toolbar to the user.

## Creating multiple tabs

It is time to create tabs and add interesting things to them.
First, we will make a tab with `wxTreeCtrl` demo.
`wxTreeCtrl` control allows to add tree view and represent hierarchical information.
 Add a private pointers to `wxNotebook` and `wxTreeCtrl` in our `Frame` class and use the following code in our `Frame` constructor:

{% highlight cpp linenos %}

 notebook = new wxNotebook(this,wxID_ANY);

 tree = new wxTreeCtrl(notebook,wxID_ANY);
 notebook->AddPage(tree,"Tree example");
 tree->SetBackgroundColour(wxColour(240,240,240));
{%endhighlight %}

Here we create the `wxNotebook` object as a child for our Frame and a `wxTreeCtrl` object as a child of `wxNotebook`.
 Next, we add a page containing our tree object to the notebook with the function `wxNotebook::AddPage()``.
  We also set the background color to very light for tree object. You can use `SetBackgroundColour()`` method for any window type.
Next I will demonstrate the usage of `wxTreeCtrl`:

{% highlight cpp linenos %}

    tree->SetWindowStyle(wxTR_HIDE_ROOT); //hides the real root node to have many roots
    wxTreeItemId root = tree->AddRoot("invisible root");//this root will be invisible
    wxTreeItemId r1 = tree->AppendItem(root, "Root1");
    wxTreeItemId r2 = tree->AppendItem(root,"Root2");
    tree->AppendItem(r1,"Node1");
    tree->AppendItem(r1,"Node2");
    tree->AppendItem(r2,"Node3");
{%endhighlight %}

The `wxTR_HIDE_ROOT` style flag hides the real root of tree.
We need this in order to have many independent roots (which actually are nodes of hidden root).
Every node in `wxTreeCtrl` is of type `wxTreeItemId`.
We first add invisible root and the use the returned element `ID` to append childs
to it with a help of function `wxTreeCtrl::AppendItem()`.
 Now we are going to implement the event for node selection. Add function prototype in our `Frame` class:

    void OnTreeItemSelected(wxTreeEvent& event);

The definition:
{% highlight cpp linenos %}
void Frame::OnTreeItemSelected(wxTreeEvent& event)
{
    wxTreeItemId selectedItem = event.GetItem();
    if(!tree->ItemHasChildren(selectedItem)) //report only if node was selected
        wxMessageBox("Selected node name: "+tree->GetItemText(selectedItem), "Node selected!");
    else
        tree->Expand(selectedItem); //othervise just expand the item
    return;
}
{%endhighlight %}

We use `wxTreeEvent` object to get the selected item.
Next we check whether this item has no child nodes(so it is node itself) and if so display the message box with the name of the selected node.
If one of the roots was selected we expand it to show child nodes.
To specify this function as the event handler for tree object, we use the `EVT_TREE_ITEM_ACTIVATED` macro.
We specify `wxID_ANY` as `ID` for our event because we have only one tree object.

Well, let's add another tab to our window. We will place a code editor there.
For full featured text editor with code highlighting the `wxStyledTextCtrl` is used.
This is a wrapper around `Scintilla` code editing component.
Despite the real complexity of code editor, using `wxStyledTextCtrl` is rather simple and the results are really nice.
So include `wx/stc/stc.h` header file in `main.h` and add private to `wxStyledTextCtrl` in `private` section. Add the following code to `Frame` constructor:
{% highlight cpp linenos %}
//create Scintilla text editor object
    editor = new wxStyledTextCtrl(notebook,wxID_ANY,wxDefaultPosition,this->GetSize());
    notebook->AddPage(editor,"Editor");
 //set our font for the whole text. We should specify this before defining styles for particular things (keywords, numbers, string, etc.)
 wxFont font(12,wxFONTFAMILY_DEFAULT,wxFONTSTYLE_NORMAL,wxFONTWEIGHT_NORMAL);
 editor->StyleSetFont(wxSTC_STYLE_DEFAULT,font);
    editor->StyleSetForeground (wxSTC_STYLE_LINENUMBER, wxColour (75, 75, 75) );
    editor->SetCaretLineVisible(true); //enable current line highlighting
    editor->SetCaretLineBackground(wxColour(245,245,255)); //very light highliting color for active line
    editor->StyleSetBackground (wxSTC_STYLE_LINENUMBER, wxColour (220, 220, 220));
    editor->SetMarginWidth(0,55);
    editor->SetMarginType (0, wxSTC_MARGIN_NUMBER);
    editor->StyleClearAll();
    editor->SetLexer(wxSTC_LEX_CPP);
    editor->StyleSetForeground (wxSTC_C_STRING,wxColour(150,0,0));
    editor->StyleSetForeground (wxSTC_C_PREPROCESSOR,wxColour(0,150,105));
    editor->StyleSetForeground (wxSTC_C_IDENTIFIER,wxColour(0,0,0));
    editor->StyleSetForeground (wxSTC_C_NUMBER,wxColour(0,150,0));
    editor->StyleSetForeground (wxSTC_C_CHARACTER,wxColour(150,0,0));
    editor->StyleSetForeground (wxSTC_C_WORD,wxColour(32,100,200));
    editor->StyleSetForeground (wxSTC_C_COMMENT,wxColour(150,150,150));
    editor->StyleSetForeground (wxSTC_C_COMMENTLINE,wxColour(150,150,150));
    editor->StyleSetBold(wxSTC_C_WORD, true);

    //list of c++ 11 keywords from http://en.cppreference.com/w/cpp/keyword
 editor->SetKeyWords(0, wxT("alignas alignof and and_eq asm auto bitand bitor bool break case catch char char16_t char32_t class compl const constexpr "
                            "const_cast continue decltype default delete do double dynamic_cast else"
                            "enum explicit export extern false float for friend goto if inline int long mutable namespace new noexcept not not_eq nullptr operator or or_eq private protected public register reinterpret_cast"
                            "return short signed sizeof static static_assert static_cast struct switch template this thread_local throw true try typedef typeid typename union unsigned using virtual void volatile wchar_t while xor xor_eq"));
{%endhighlight %}

First we create the editor object and add it as a page to our notebook.
Next we specify a global font before setting particular styling for keywords, strings, numbers etc.
After that we enable current line highlighting and set the highlight color.
We also specify the left margin attributes for line numbers and then begin styling the C++ lexicon.
First we choose the lexer as `wxSTC_LEX_CPP`. There are a number of predefined lexers.
To see the corresponding defines look into `wx/stc/stc.h` file.
After that we specify individual colors for strings(enclosed in double quotes),
preprocessor, identifiers, numbers, characters (enclosed in a single quotes),
keywords, line comments, and multiline comments.
We also enable bold font for keywords.
What goes next is a list of all C++ 11 keywords for keyword set 0 (that is our `wxSTC_C_WORD`).

Now lets add an ability to open files. We will define `Frame::OnOpen()` event handler.
Try adding the event handler to the event table on your own. And here is the implementation of `Frame::OnOpen()` function:

{% highlight cpp linenos %}
void Frame::OnOpen(wxCommandEvent &event)
{
    wxString p = wxFileSelector("Open file", "",
    "", "");
 if(p!=wxEmptyString)
 {
        ifstream file(p);
        if(!file.is_open())
        {
            wxMessageBox("Error opening file","Error");
            return;
        }
        fileName = p;
        //read file contents
        string val, full;
        while(file.good())
        {
            getline(file,val);
            full+=val+"\n";
        }
        file.close();
        editor->SetText(full);
        //convert all EOLs to one mode. If you do not understand the reason of this call, comment it out and try out.
        //Some lines will not be detected by Scintilla
        editor->ConvertEOLs(wxSTC_EOL_LF);

 }
}
{% endhighlight %}

We use `wxFileSelector()` function to display file selection dialog.
 The first parameter is dialog name and the other three are default path, default file name, default extension and wildcard,
 which we left empty for simplicity.
 If the returned file name string is not empty(the user selected file) we open and read it with
 `std::ifstream` and set the text to display in editor with function `wxStyledTextCtrl::SetText()`.
  Furthermore, we set the member `std::string` variable `fileName` to the file name of opened file.
   We will use this variable to implement file saving. So, here is `OnSave()` event handler:

{% highlight cpp linenos %}
void Frame::OnSave(wxCommandEvent& event)
{
        if(fileName.length()<=0)
        {
            wxString p = wxSaveFileSelector("", "All Files|*.*|C++ Source Files (*.cpp) |*.cpp| C/C++ Header Files (*.h) |*.h", "new");
            if(p!=wxEmptyString)
            {
                fileName = p;
            }
        }
        ofstream of(fileName.c_str());
        of.write(editor->GetText(),editor->GetLength());
        of.close();
}
{%endhighlight %}

The `wxSaveFileSelector()` function shows a save file dialog to the user if the `fileName` is not set.
 Here we use the wildcard to give the user option to chose file extension.

The last part of tutorial is `GDI` (Graphics Device Interface) of `wxWidgets` library.
In this part we will create a simple paint program.
So let's add one more tab to our notebook and a private member pointer to wxWindow in our `Frame` class.
To do drawing in `wxWidgets`, we need a device context, which is encapsulated in `wxPaintDC` class.
The `wxPaintDC` class has various methods to draw lines, points, rectangles, text , circles and bitmaps.
 When window is moved to another position, we need to redraw our graphics. That is why the `EVT_PAINT` event exists.
 However, this event triggers only when the window needs to be redrawn but not when we need to redraw it.
  To have more frequent updates we can use the special `EVT_IDLE` event macro.
   This event triggers all the time when the window becomes idle. This way we can capture input and draw quite frequently.
Using the paint program we will write it is possible to draw arbitary lines and change background color.
Every line consists of two points. To store points I declared such a structure:

{% highlight cpp linenos %}
struct Point
{
    Point(int _x, int _y, wxColour c, int w) : x(_x), y(_y),color(c), width(w) {}
    int x;
    int y;
    int width;
    wxColour color;
};
{% endhighlight %}

The width member specifies the width of line to be drawn from this point and the
 color specifies the color of the line to be drawn. We also should add some members to our `Frame` class:
{% highlight cpp linenos %}
    std::vector<Point> points;
    wxColour pointColor, bgColor, prevBgColor;
    int lineWidth;
    bool wasReleased;
{% endhighlight %}

The points is an array of points to be drawn.
 The `pointColo`r and `bgColor` are used to store the currently selected line color and background color.
 However, we do not need to redraw background color every time.
 We will do this only when the `bgColor` is changed.
 That is why the `prevBgColor` member is declared.
 If `bgColor != prevBgColor`, we will draw a rectangle of color `bgColo`r and set `prevBgColor` to `bgColor`.
  The `wasReleased` indicates whether the user released left mouse button.
  If so, we have to insert special point with coordinates `(-1;-1)`,
  which will not be skipped in our drawing function. Having these bits together, here is the drawing code:

{% highlight cpp linenos %}
void Frame::Redraw(wxDC &dc)
{
    if(bgColor!=prevBgColor)
    {
        dc.SetBrush(wxBrush(bgColor));
        dc.DrawRectangle(0,0,gdiExample->GetSize().x,gdiExample->GetSize().y);
        prevBgColor = bgColor;
    }
    for(int i = 0;i<points.size();i++) //draw our points
    {
        dc.SetPen(wxPen(points[i].color,points[i].width,wxPENSTYLE_SOLID));
        if((points[i].x==-1&&points[i].y==-1)||points[i>0?i-1:0].x==-1&&points[i>0?i-1:0].y==-1) //check if there are magic values which indicate the line break
            continue;
        dc.DrawLine(wxCoord(points[i>0?i-1:0].x),wxCoord(points[i>0?i-1:0].y),wxCoord(points[i].x),wxCoord(points[i].y));
    }
}
{% endhighlight %}

The `Redraw()` function takes as parameter a `wxDC` object which is the base class for
 `wxPaintDC` and other device context objects. I will tell you the reason for this later.
 To draw a rectangle(background color) we need to specify a brush to use.
 The we set a pen object to draw lines.
 We loop through our points array and draw the lines between the current and previous point.
 If we encounter a special point with coordinates `(-1;-1)`, we skip the current point to create a line break.
At this point it is time to write code for capturing user input.The `GetInput()`
 is an idle event handler which creates points if user is pressing left mouse button and calls `Redraw()` function:

{% highlight cpp linenos %}
void Frame::GetInput(wxIdleEvent& event)
{
    wxMouseState state = wxGetMouseState();
    if(notebook->GetSelection()==1)
        if(state.LeftIsDown())
            {
                int cx,cy;
                cx = gdiExample->GetScreenPosition().x;
                cy = gdiExample->GetScreenPosition().y;
                points.push_back(Point(state.GetX()-cx,state.GetY()-cy,pointColor, lineWidth));
                wasReleased = false;
            }
            else
            {
                if(!wasReleased)
                {
                    points.push_back(Point(-1,-1,pointColor,lineWidth));
                    wasReleased = true;
                }
            }
    wxPaintDC dc(gdiExample);
    Redraw(dc);
}
{% endhighlight %}

We retrieve current `wxMouseState` object with `wxGetMouseState()` function.
Then we can check whether left mouse button is pressed with `wxMouseState::LeftIsDown()` method.
We than add a point at coordinates of mouse pointer. However, `wxMouseState::GetX()` and
`wxMouseState::GetY()` return the screen space pointer coordinates.
We need to add the position of `gdiExample` window to get the coordinates locally to the top left corner of window in which we draw.
 If mouse button is not pressed and the special point `(-1;-1)` has not been inserted
 yet(which is indicated by `wasReleased` variable) we insert it.
 Finally, we create `wxPaintDC` object for our gdiExample window and pass it to the `Redraw()` function.

The last piece of our mosaic is to implement image saving.
I showed the definition of `OnSave()` event handler earlier when we were dealing with text editor.
And here is now its modified version. If the pain tab is selected, we save the image, otherwise we save a text file:

{% highlight cpp linenos %}
void Frame::OnSave(wxCommandEvent& event)
{
    if(notebook->GetSelection()==1) //our simple paint program
    {
        wxMemoryDC memDC; //create memore dc into which we will draw our image
        wxBitmap image(gdiExample->GetSize().x,gdiExample->GetSize().y); //create bitmap on which the image will be drawn
        memDC.SelectObject(image); //set the bitmap to be drawn
        memDC.Clear();
        //redraw with updating background color
        memDC.SetBrush(wxBrush(bgColor));
        memDC.DrawRectangle(0,0,gdiExample->GetSize().x,gdiExample->GetSize().y);
        Redraw(memDC); //actually draw our image to memory
        memDC.SelectObject(wxNullBitmap); //free the bitmap
        wxString p = wxSaveFileSelector("", "PNG Image|*.png|BMP Image|*.bmp|JPEG Image|*.jpg", "image");
        if(p!=wxEmptyString)

        {
            wxString path,name,extension;
            wxSplitPath(p,&path,&name,&extension);
            if(extension=="jpg")
                image.SaveFile(p,wxBITMAP_TYPE_JPEG,NULL);
            if(extension=="png")
                image.SaveFile(p,wxBITMAP_TYPE_PNG,NULL);
            if(extension=="bmp")
                image.SaveFile(p, wxBITMAP_TYPE_BMP,NULL);
        }


    }
    if(notebook->GetSelection()==2) //we are in editor tab
    {
        if(fileName.length()<=0)
        {
            wxString p = wxSaveFileSelector("", "All Files|*.*|C++ Source Files (*.cpp) |*.cpp| C/C++ Header Files (*.h) |*.h", "new");
            if(p!=wxEmptyString)
            {
                fileName = p;
            }
        }
        ofstream of(fileName.c_str());
        of.write(editor->GetText(),editor->GetLength());
        of.close();
    }
}
{% endhighlight %}

The `wxNotebook::GetSelection()` returns the index of currently selected tab.
In this piece of code it is assumed that the paint tab is the second and the editor tab it the third tab from the left.
We than create special `wxMemoryDC` object which features drawing into a `wxBitmap` object.
We redraw the background and call our `Redraw()` function to draw our points into `memDC`.
Eventually, we save the bitmap in `JPEG`, `PNG` or `BMP` format.


![Our paint program in action](/public/wxwidgets-tutorial/paint-shot.png "Our paint program in action")

## Conclusion

This is the finish. At this point you are able to create nice applications with a help of `wxWidgets` library.
However, there are a lot of things which I haven't covered in this tutorial.
Just explore the documentation and Wiki to find out more. For example, `wxWidgets` features rendering with `OpenGL` to one of it's controls.
 Furthermore, you can render `HTML` documents very simply with a help of `wxHTMLWindow`.
  Experiment with those things and gain the experience. Good luck!
