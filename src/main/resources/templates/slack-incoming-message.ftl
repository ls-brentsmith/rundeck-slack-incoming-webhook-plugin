<#if executionData.job.group??>
    <#assign jobName="${executionData.job.group} / ${executionData.job.name}">
<#else>
    <#assign jobName="${executionData.job.name}">
</#if>
<#assign message="<${executionData.href}|Execution #${executionData.id}> of job <${executionData.job.href}|${jobName}>">
<#if trigger == "start">
    <#assign state="Started">
<#elseif trigger == "failure">
    <#assign state="Failed">
<#else>
    <#assign state="Succeeded">
</#if>

{
   "attachments":[
      {
         "fallback":"${state}: ${message}",
         "pretext":"${message}",
         "color":"${color}",
         "fields":[
            {
               "title":"Job Name",
               "value":"<${executionData.job.href}|${jobName}>",
               "short":true
            },
            {
               "title":"Project",
               "value":"${executionData.project}",
               "short":true
            },
            {
               "title":"Status",
               "value":"${state}",
               "short":true
            },
            {
               "title":"Execution ID",
               "value":"<${executionData.href}|#${executionData.id}>",
               "short":true
            },
<#list executionData.context.option?keys as key>
            {
               "title":"${key}",
               "value":"${executionData.context.option[key]}",
               "short":true
            },
</#list>
            {
               "title":"Started By",
               "value":"${executionData.user}",
               "short":true
            }
<#if trigger == "failure">
            ,{
               "title":"Failed Nodes",
               "value":"${executionData.failedNodeListString!"- (Job itself failed)"}",
               "short":false
            }
</#if>
        ]
      }
   ]
}
