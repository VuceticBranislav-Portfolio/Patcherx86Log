program Patcherx86Log;

(*----------------------------------------------------------------------------------------

Author  : Branislav Vucetic
Version : v1.1
Date    : 02.05.2020
Licence : CC0 1.0

Description :
    Patcherx86Log help to investigate Patcherx86 log file. Program list all pathes in file.
    Represent data in table and provide sorting. File can be reloaded anytime.
    Patcherx86Log can be started by dropping file on desktop icon.

Revision :
    v1.0 - Initial version
    v1.1 - Program remake. Added some features.

------------------------------------------------------------------------------------------

Patcherx86Log by Branislav Vucetic

To the extent possible under law, the person who associated CC0 with
Patcherx86Log has waived all copyright and related or neighboring rights
to Patcherx86Log.

You should have received a copy of the CC0 legalcode along with this
work. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

----------------------------------------------------------------------------------------*)

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {PatcherForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPatcherForm, PatcherForm);
  Application.Run;
end.
