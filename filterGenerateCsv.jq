def getNodeMetrics:
    [.items[]|
    {
        name:.metadata.name,
        cpu:.usage.cpu, 
        memory:.usage.memory
    }
    ];


# use geNodeUsages to generate csv
.[] |
getNodeMetrics |
group_by(.name) |
map({
  "Node Name": .[].name ,
  "CPU Node - Real": [.[].cpu] | add, 
  "Memory Node - Real": [.[].memory] | add
})| (.[0] | to_entries | map(.key)), (.[] | [.[]]) | @csv