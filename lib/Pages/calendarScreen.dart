import 'package:flutter/material.dart';
import 'package:practice_app/Custom_Widgets/Agenda_Widget.dart';
import 'package:practice_app/Custom_Widgets/PublicVariables.dart' as globals;
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  List _selectedEvents;
  List _dueEvents;

  int _todayEventsIndex;

  //This is important for when we will be comparing dates
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  //This is the method that will be called every time we select a day to determine
  //what to show for that day
  List _getEventsForDay(DateTime day) {
    //This list wil contain both of the lists and will be separated in another function
    List totalEvents = [''];

    //initializes a temporary list with an empty string just so we can use add method
    List events = [''];

    //This iterrates through the global list of agendas and checks to see if the
    //date matches the selected date.
    //Then it adds each item in that calendar to the temporary list that this
    //method will return
    for (Agenda agenda in globals.agendaDisplay) {
      if (formatter.format(agenda.getCreationDate()) == formatter.format(day)) {
        for (Item item in agenda.getItemList()) {
          events.add(item.toCalendarString());
        }
      }
    }

    //remove the temporary empty string
    events.remove('');

    for (String event in events) {
      totalEvents.add(event);
    }
    totalEvents.remove('');

    //this is the second list that will be used to display only items due that day
    List dueEvents = [''];
    //checks through every agenda regardless of date and looks for item whos
    //due date matches the current day
    for (Agenda agenda in globals.agendaDisplay) {
      for (Item item in agenda.getItemList()) {
        if (formatter.format((item.getDeadline())) == formatter.format(day)) {
          dueEvents.add(item.toCalendarString());
        }
      }
    }
    dueEvents.remove('');
    for (String event in dueEvents) {
      totalEvents.add(event);
    }

    return totalEvents;
  }

  //this method is called every time a new day is selected and first checks to
  //make sure its not the same day, then it updates all the variables.
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _todayEventsIndex = 0;
        for (Agenda agenda in globals.agendaDisplay) {
          if (formatter.format(agenda.getCreationDate()) ==
              formatter.format(selectedDay)) {
            for (Item item in agenda.getItemList()) {
              _todayEventsIndex++;
            }
          }
        }

        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents = _getEventsForDay(selectedDay);
      });
    }
  }

  //Sets the selected day to current date
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _todayEventsIndex = 0;
    for (Agenda agenda in globals.agendaDisplay) {
      if (formatter.format(agenda.getCreationDate()) ==
          formatter.format(_selectedDay)) {
        for (Item item in agenda.getItemList()) {
          _todayEventsIndex++;
        }
      }
    }
    _selectedEvents = _getEventsForDay(_selectedDay);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.colorSelected.getColor(),
        title: Text('Calendar'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            while (globals.pagesPushed > 0) {
              Navigator.pop(context);
              globals.pagesPushed--;
            }
          },
        ),
      ),
      //use SingleChildScrollView because it will allow the page to expand to
      //accomodate more items if needed
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime(2021, 1, 1),
              lastDay: DateTime(2030, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              headerVisible: true,
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            //Container with text separating events from the calendar
            Container(
              child: Text('Todays Agenda',
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            //This adds every item in selected events to the empty space below
            //the calendar.
            //NOTE: the ... symbol is used to combine sets of data within lists so
            //because the column is technically a list this is adding each event
            //in selected events to the column. This is pretty much the same thing
            //used in the display screen but the ... is needed because there are
            //other widgets aside from the map function that need to get combined into the column.
            ..._selectedEvents
                .getRange(0, _todayEventsIndex)
                .map((event) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Text(
                          event,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                      ),
                    )),
            Container(
              child: Text('Due Today',
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            //This is what displayes the events that are due on that day
            ..._selectedEvents
                .getRange(_todayEventsIndex, _selectedEvents.length)
                .map((event) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Text(
                          event,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
