<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>Bundle</sch:title>
    <sch:rule context="/f:DomainResource">
      <sch:assert test="exists(for $id in f:contained/*/@id return $id[not(ancestor::f:contained/parent::*/descendant::f:reference/@value=concat('#', $id))])">Inv-3: If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource</sch:assert>
      <sch:assert test="not(parent::f:contained and f:contained)">Inv-2: If the resource is contained in another resource, it SHALL not contain nested Resources</sch:assert>
      <sch:assert test="not(parent::f:contained and f:text)">Inv-1: If the resource is contained in another resource, it SHALL not contain any narrative</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DomainResource/f:text/f:div">
      <sch:assert test="not(descendant-or-self::*/@*[not(name(.)=('abbr', 'accesskey', 'align', 'alt', 'axis', 'bgcolor', 'border', 'cellhalign', 'cellpadding', 'cellspacing', 'cellvalign', 'char', 'charoff', 'charset', 'cite', 'class', 'colspan', 'compact', 'coords', 'dir', 'frame', 'headers', 'height', 'href', 'hreflang', 'hspace', 'id', 'lang', 'longdesc', 'name', 'nowrap', 'rel', 'rev', 'rowspan', 'rules', 'scope', 'shape', 'span', 'src', 'start', 'style', 'summary', 'tabindex', 'title', 'type', 'valign', 'value', 'vspace', 'width'))])">Inv-3: The narrative SHALL contain only the basic html formatting attributes described in chapters 7-11 (except section 4 of chapter 9) and 15 of the HTML 4.0 standard, &lt;a&gt; elements (either name or href), images and internally contained style attributes</sch:assert>
      <sch:assert test="descendant::text()[normalize-space(.)!=''] or descendant::h:img[@src]">Inv-2: The narrative SHALL have some non-whitespace content</sch:assert>
      <sch:assert test="not(descendant-or-self::*[not(local-name(.)=('a', 'abbr', 'acronym', 'b', 'big', 'blockquote', 'br', 'caption', 'cite', 'code', 'colgroup', 'dd', 'dfn', 'div', 'dl', 'dt', 'em', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'hr', 'i', 'img', 'li', 'ol', 'p', 'pre', 'q', 'samp', 'small', 'span', 'strong', 'table', 'tbody', 'td', 'tfoot', 'th', 'thead', 'tr', 'tt', 'ul', 'var'))])">Inv-1: The narrative SHALL contain only the basic html formatting elements described in chapters 7-11 (except section 4 of chapter 9) and 15 of the HTML 4.0 standard, &lt;a&gt; elements (either name or href), images and internally contained style attributes</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DomainResource/f:contained/f:meta/f:security">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">Inv-1: If a valueSet is provided, a system URI Is required</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DomainResource/f:contained/f:meta/f:security/f:valueSet">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">Inv-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DomainResource/f:contained/f:meta/f:tag">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">Inv-1: If a valueSet is provided, a system URI Is required</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DomainResource/f:contained/f:meta/f:tag/f:valueSet">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">Inv-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Bundle">
      <sch:assert test="not(f:entry/f:search) or (f:type/@value = 'transaction')">Inv-2: Search only when transaction</sch:assert>
      <sch:assert test="not(f:entry/f:status) or (f:type/@value = 'transaction') or (f:type/@value = 'search')">Inv-1: Status only when transaction or search</sch:assert>
      <sch:assert test="not(f:entry/f:status) or (f:type/@value = 'transaction') or (f:type/@value = 'history')">Inv-5: Status only when transaction or history</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Bundle/f:entry">
      <sch:assert test="not(f:status) or f:resource">Inv-3: status only when resource</sch:assert>
      <sch:assert test="not(f:deleted) or not(f:resource)">Inv-4: deleted or resource (but not both)</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Bundle/f:entry/f:resource/f:meta/f:security">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">Inv-1: If a valueSet is provided, a system URI Is required</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Bundle/f:entry/f:resource/f:meta/f:security/f:valueSet">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">Inv-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Bundle/f:entry/f:resource/f:meta/f:tag">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">Inv-1: If a valueSet is provided, a system URI Is required</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Bundle/f:entry/f:resource/f:meta/f:tag/f:valueSet">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">Inv-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
