# redmine-sparkline
Adds a sparkline to show issue's completion rate (Done %) in graphics.

The sparkline is displayed on issue list within the `Done %` column and on issue detail (see snapshots).
![sparkline-issue list](https://user-images.githubusercontent.com/37396169/121325760-2c043680-c912-11eb-8174-7e39a9eb3da4.png)
![sparkline-issue detail](https://user-images.githubusercontent.com/37396169/121325787-31fa1780-c912-11eb-90d8-73888f305715.png)

Following can be set in the plugin configuration:
- global settings: line color and fill color using HTML color names
- project settings (default in global settings):
  - start point in time (sparkline's left edge): issue creation date or last few days (days offset value)
  - end point in time (sparkline's right edge): today or issue due date

Plugin functionality can be enabled for selected project as module.
