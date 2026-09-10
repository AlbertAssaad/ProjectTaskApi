page 50200 "Project Tasks API"
{
    PageType = API;
    Caption = 'Project Tasks API';
    APIPublisher = 'albertassaad';
    APIGroup = 'projectMgmt';
    APIVersion = 'v1.0';
    EntityName = 'projectTask';
    EntitySetName = 'projectTasks';
    EntityCaption = 'Project Task';
    EntitySetCaption = 'Project Tasks';
    SourceTable = "Project Task";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'Number';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(completedOn; Rec."Completed On")
                {
                    Caption = 'Completed On';
                    Editable = false;
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.ReadIsolation := IsolationLevel::ReadCommitted;
    end;

    [ServiceEnabled]
    procedure completeTask(var ActionContext: WebServiceActionContext)
    var
        ProjectTask: Record "Project Task";
        ProjectTaskMgt: Codeunit "Project Task Mgt.";
    begin
        ProjectTask.GetBySystemId(Rec.SystemId);
        ProjectTaskMgt.CompleteTask(ProjectTask);

        ActionContext.SetObjectType(ObjectType::Page);
        ActionContext.SetObjectId(Page::"Project Tasks API");
        ActionContext.AddEntityKey(Rec.FieldNo(SystemId), ProjectTask.SystemId);
        ActionContext.SetResultCode(WebServiceActionResultCode::Updated);
    end;
}