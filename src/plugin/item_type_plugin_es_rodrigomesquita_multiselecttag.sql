set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.4.00.12'
,p_default_workspace_id=>68655333203588800947
,p_default_application_id=>37671
,p_default_owner=>'RODRIGO'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/item_type/es_rodrigomesquita_multiselecttag
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(37314066202881823424)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'ES.RODRIGOMESQUITA.MULTISELECTTAG'
,p_display_name=>'Apex Multi-select Tag '
,p_supported_ui_types=>'DESKTOP'
,p_css_file_urls=>'#PLUGIN_FILES#css/tagcloud.css'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  function render_item (',
'    p_item                in apex_plugin.t_page_item,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_value               in varchar2,',
'    p_is_readonly         in boolean,',
'    p_is_printer_friendly in boolean )',
'    return apex_plugin.t_page_item_render_result ',
'   AS  ',
'   ',
'    v_result apex_plugin.t_page_item_render_result; ',
'    v_page_item_name varchar2(100);',
'    v_static_values p_item.attribute_01%type := p_item.attribute_01;',
'    v_max_num_values p_item.attribute_02%type := p_item.attribute_02;',
'    v_sql_query p_item.attribute_04%type := p_item.attribute_04;',
'    v_source_type p_item.attribute_03%type := p_item.attribute_03;',
'    ',
'    v_row_value varchar2(1000);',
'    v_html varchar2(9000);',
'    v_num_values number := 0;',
'    v_item_value varchar2(100);',
'    v_selected varchar2(100);',
'    v_value varchar2(100);',
'    lCur_col1   VARCHAR2(1000);',
'    lCur_col2   VARCHAR2(1000);',
'    l_vc_arr2    APEX_APPLICATION_GLOBAL.VC_ARR2;',
'    lcursor      SYS_REFCURSOR;',
' ',
'    ',
'  BEGIN',
'',
'    v_item_value := p_value;',
'    v_page_item_name := apex_plugin.get_input_name_for_page_item(p_is_multi_value => TRUE);',
'    l_vc_arr2 := APEX_UTIL.STRING_TO_TABLE(v_item_value);    ',
'',
'  ',
'    ',
'      /* ********** Item rendering   ********* */',
'',
'            htp.p(''<select id="''||p_item.name||''" name="''||v_page_item_name||''" class="multi_selectlist" multiple="multiple" size="5">'');',
'',
'',
'     if v_source_type = ''S'' Then',
'',
'     while v_static_values is not null loop',
'            v_num_values := v_num_values+1;',
'            if instr(v_static_values,'','')>0 then',
'                v_row_value := substr(v_static_values,1,instr(v_static_values,'','')-1);',
'                v_static_values := substr(v_static_values,instr(v_static_values,'','')+1,length(v_static_values));  ',
'             else',
'             v_row_value := v_static_values;',
'             v_static_values := null; ',
'             end if;',
'             v_value := substr(v_row_value,instr(v_row_value,'';'')+1,length(v_row_value));',
'             v_selected := '''';',
'             FOR z IN 1..l_vc_arr2.count LOOP',
'             if v_value = l_vc_arr2(z) Then',
'                v_selected := ''selected="selected"'';',
'             end if;  ',
'             END LOOP;',
' ',
'             ',
'            htp.p(''<option value="''||v_value||''"  ''||v_selected||'' >''||',
'                                    upper(substr(v_row_value,1,instr(v_row_value,'';'')-1)) || ''</option>'');               ',
'           end loop;',
'           ',
'      Else',
'',
'       OPEN lcursor FOR v_sql_query;',
'      Loop ',
'         Fetch lcursor',
'          INTO lCur_col1,lCur_col2;',
'          EXIT WHEN lcursor%NOTFOUND;',
'             v_selected := '''';',
'             FOR z IN 1..l_vc_arr2.count LOOP',
'             if lCur_col1 = l_vc_arr2(z) Then',
'                v_selected := ''selected="selected"'';',
'             end if; ',
'             end loop;',
'          htp.p(''<option value="''||lCur_col1||''"  ''||v_selected||'' >''||',
'                                    lCur_col2 || ''</option>''); ',
'      END LOOP;',
'          CLOSE lcursor;',
'          ',
'      end if;',
'           ',
'           htp.p(''</select>'');',
'',
'      /* ********** javascript   ********* */',
'',
'       if v_max_num_values is null Then',
'          v_max_num_values :=  v_num_values;',
'       end if;  ',
'',
'       v_html := ''$(''||p_item.name||'').tagcloud({',
'                                       max: ''||v_max_num_values||''',
'                                      });'';    ',
'                                      ',
'',
' ',
'       apex_javascript.add_library (p_name => ''tagcloud'', p_directory => p_plugin.file_prefix, p_version=> '''');',
'          ',
'       apex_javascript.add_onload_code (p_code => v_html);',
'   ',
'',
'      v_result.is_navigable := FALSE;',
'',
' ',
'    RETURN v_result;',
'  end render_item;'))
,p_render_function=>'render_item'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:SOURCE:ENCRYPT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>',
'	This is Apex Multi-select Tag page item based on JQuery plugin TagCloud (http://www.jqueryscript.net/form/Multi-select-Tag-Cloud-Plugin-With-jQuery-TagCloud.html).</p>',
'<p>',
'	Enables user friendly select a list options</p>',
'<p>',
'	Dual licensed under the MIT (MIT-LICENSE.txt) and GPL (GPL-LICENSE.txt) licenses.</p>'))
,p_version_identifier=>'2.0'
,p_about_url=>'orclapextips.blogspot.com'
,p_files_version=>16
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(37314152433689337434)
,p_plugin_id=>wwv_flow_api.id(37314066202881823424)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Static Values'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>true
,p_default_value=>'display1;return1,display2;return2'
,p_display_length=>100
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(41128445623633937740)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'S'
,p_help_text=>'display1;return1,display2;return2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(37409550030332865047)
,p_plugin_id=>wwv_flow_api.id(37314066202881823424)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Max Num of Selected values'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'3'
,p_display_length=>2
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>'Specify the maximum number of options can be selected'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(41128445623633937740)
,p_plugin_id=>wwv_flow_api.id(37314066202881823424)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>5
,p_prompt=>'Source Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'S'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(41128465442907945469)
,p_plugin_attribute_id=>wwv_flow_api.id(41128445623633937740)
,p_display_sequence=>5
,p_display_value=>'Static Values'
,p_return_value=>'S'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(41128463091367943292)
,p_plugin_attribute_id=>wwv_flow_api.id(41128445623633937740)
,p_display_sequence=>10
,p_display_value=>'SQL Query'
,p_return_value=>'Q'
,p_help_text=>'I.E. select column, value from table'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(41130041563467292314)
,p_plugin_id=>wwv_flow_api.id(37314066202881823424)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'SQL Query'
,p_attribute_type=>'SQL'
,p_is_required=>false
,p_sql_min_column_count=>2
,p_sql_max_column_count=>2
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(41128445623633937740)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Q'
,p_help_text=>'select column_value, column_display from table'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '0A0A2E74632D77726170706572207B0A2020646973706C61793A20626C6F636B3B0A20206865696768743A20313030253B0A7D0A0A0A2E74632D746167207B0A2020646973706C61793A20696E6C696E652D626C6F636B3B0A202070616464696E673A20';
wwv_flow_api.g_varchar2_table(2) := '3570783B0A20206D617267696E3A20302031307078203130707820303B0A20206261636B67726F756E643A20236565653B0A2020637572736F723A20706F696E7465723B0A2020666F6E742D73697A653A20313070783B0A7D0A0A2E74632D73656C6563';
wwv_flow_api.g_varchar2_table(3) := '746564207B6261636B67726F756E643A20233235373863663B636F6C6F723A2077686974653B7D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(37406822128362346690)
,p_plugin_id=>wwv_flow_api.id(37314066202881823424)
,p_file_name=>'css/tagcloud.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A0A2020202054616720436C6F7564202D2041206A51756572792054616720436C6F75642047656E657261746F720A2020202056657273696F6E20312E302E300A202020205279616E204669747A676572616C640A2020202068747470733A2F2F5279';
wwv_flow_api.g_varchar2_table(2) := '616E4669747A676572616C642E63612F0A202020202D2D2D0A202020205265706F3A20687474703A2F2F6769746875622E636F6D2F7279616E6669747A676572616C642F746167636C6F75640A202020204973737565733A20687474703A2F2F67697468';
wwv_flow_api.g_varchar2_table(3) := '75622E636F6D2F7279616E6669747A676572616C642F746167636C6F75642F6973737565730A202020204C6963656E73656420756E646572204D4954204F70656E20536F757263650A202A2F0A0A2866756E6374696F6E282429207B0A0A20202020242E';
wwv_flow_api.g_varchar2_table(4) := '666E2E746167636C6F7564203D2066756E6374696F6E286F7074696F6E7329207B0A0A20202020202020202F2F204F7665726964652064656661756C74732C2069662070726F76696465640A20202020202020207661722073657474696E6773203D2024';
wwv_flow_api.g_varchar2_table(5) := '2E657874656E64287B0A2020202020202020202020206D61783A20312F300A20202020202020207D2C206F7074696F6E73293B0A0A20202020202020202F2F20416C6C6F7720636861696E696E6720616E642070726F63657373206561636820444F4D20';
wwv_flow_api.g_varchar2_table(6) := '6E6F64650A202020202020202072657475726E20746869732E656163682866756E6374696F6E2829207B0A0A2020202020202020202020202F2F202D2D2D20446566696E65205661726961626C6573202D2D2D0A20202020202020202020202076617220';
wwv_flow_api.g_varchar2_table(7) := '2474686973203D20242874686973293B202F2F2053746F7265207265666572656E636520746F2073656C660A20202020202020202020202076617220246F7074696F6E73203D2024746869732E6368696C6472656E28276F7074696F6E27293B202F2F20';
wwv_flow_api.g_varchar2_table(8) := '53746F72652073656C656374206F7074696F6E730A2020202020202020202020207661722073656C6563746564203D205B5D3B202F2F2043726561746520617272617920746F2073746F72652073656C65637465642076616C7565730A20202020202020';
wwv_flow_api.g_varchar2_table(9) := '2020202020766172206D6178203D2073657474696E67732E6D61783B0A0A2020202020202020202020202F2F20437265617465207772617070696E67206469760A20202020202020202020202024746869732E7772617028273C64697620636C6173733D';
wwv_flow_api.g_varchar2_table(10) := '2274632D77726170706572223E3C2F6469763E27293B0A0A2020202020202020202020202F2F2053746F7265207265666572656E636520746F20706172656E740A2020202020202020202020207661722024706172656E74203D2024746869732E706172';
wwv_flow_api.g_varchar2_table(11) := '656E7428293B0A0A2020202020202020202020202F2F2048696465206F726967696E616C2073656C6563740A20202020202020202020202024746869732E6869646528293B0A0A2020202020202020202020202F2F204372656174652074616720636C6F';
wwv_flow_api.g_varchar2_table(12) := '7564206469760A20202020202020202020202024746869732E616674657228273C64697620636C6173733D2274632D636C6F7564223E3C2F6469763E27290A0A2020202020202020202020202F2F2043726561746520746167730A202020202020202020';
wwv_flow_api.g_varchar2_table(13) := '202020246F7074696F6E732E656163682866756E6374696F6E286929207B0A20202020202020202020202020202069662028242874686973292E697328273A73656C65637465642729297B0A202020202020202020202020202020200A20202020202020';
wwv_flow_api.g_varchar2_table(14) := '20202020202020202024706172656E742E66696E6428272E74632D636C6F756427292E617070656E6428273C7370616E20636C6173733D2274632D7461672074632D73656C65637465642220646174612D7461673D22272B692B27223E272B2428746869';
wwv_flow_api.g_varchar2_table(15) := '73292E7465787428292B273C2F7370616E3E27293B0A202020202020202020202020202020202020200A2020202020202020202020202020202073656C65637465642E707573682869293B2020200A202020202020202020202020202020202020200A20';
wwv_flow_api.g_varchar2_table(16) := '20202020202020202020202020207D656C73657B0A20202020202020202020202020202020202024706172656E742E66696E6428272E74632D636C6F756427292E617070656E6428273C7370616E20636C6173733D2274632D7461672220646174612D74';
wwv_flow_api.g_varchar2_table(17) := '61673D22272B692B27223E272B242874686973292E7465787428292B273C2F7370616E3E27293B20200A2020202020202020202020202020207D0A2020202020202020202020207D293B0A0A2020202020202020202020202F2F204D616E61676520636C';
wwv_flow_api.g_varchar2_table(18) := '69636B730A20202020202020202020202024706172656E742E66696E6428272E74632D74616727292E636C69636B2866756E6374696F6E2829207B0A0A202020202020202020202020202020202F2F204765742063757272656E7420746167206E756D62';
wwv_flow_api.g_varchar2_table(19) := '65720A20202020202020202020202020202020766172207461674E756D203D20242874686973292E64617461282774616727293B0A0A202020202020202020202020202020202F2F20436865636B2069662069742069732073656C6563746564206F7220';
wwv_flow_api.g_varchar2_table(20) := '6E6F740A2020202020202020202020202020202069662028242874686973292E686173436C617373282774632D73656C6563746564272929207B202F2F20496620616C72656164792073656C65637465640A0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(21) := '2020202F2F2052656D6F766520636C6173730A2020202020202020202020202020202020202020242874686973292E72656D6F7665436C617373282774632D73656C656374656427293B0A0A20202020202020202020202020202020202020202F2F2055';
wwv_flow_api.g_varchar2_table(22) := '6E73656C6563742066726F6D2073656C6563740A202020202020202020202020202020202020202024746869732E66696E6428276F7074696F6E3A657128272B7461674E756D2B272927292E70726F70282773656C6563746564272C2066616C7365293B';
wwv_flow_api.g_varchar2_table(23) := '0A0A20202020202020202020202020202020202020202F2F2052656D6F76652073656C65637465642076616C75650A202020202020202020202020202020202020202073656C65637465642E73706C69636528242E696E4172726179287461674E756D2C';
wwv_flow_api.g_varchar2_table(24) := '2073656C6563746564292C2031293B0A0A202020202020202020202020202020207D20656C7365207B202F2F204966206E6F742073656C65637465640A0A20202020202020202020202020202020202020202F2F2041646420636C6173730A2020202020';
wwv_flow_api.g_varchar2_table(25) := '202020202020202020202020202020242874686973292E616464436C617373282774632D73656C656374656427293B0A0A20202020202020202020202020202020202020202F2F204164642073656C6563746564206174747269627574650A2020202020';
wwv_flow_api.g_varchar2_table(26) := '20202020202020202020202020202024746869732E66696E6428276F7074696F6E3A657128272B7461674E756D2B272927292E70726F70282773656C6563746564272C2074727565293B0A0A20202020202020202020202020202020202020202F2F2050';
wwv_flow_api.g_varchar2_table(27) := '75736820746F2073656C65637465642061727261790A202020202020202020202020202020202020202073656C65637465642E70757368287461674E756D293B0A20202020202020202020202020202020202020200A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(28) := '2020202020202F2F20436865636B206966206D617820686173206265656E207365740A20202020202020202020202020202020202020206966202873656C65637465642E6C656E677468203E206D617829207B0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(29) := '20202020202020200A0A2020202020202020202020202020202020202020202020202F2F20556E73656C6563742066726F6D2073656C6563740A20202020202020202020202020202020202020202020202024746869732E66696E6428276F7074696F6E';
wwv_flow_api.g_varchar2_table(30) := '3A657128272B73656C65637465645B305D2B272927292E70726F70282773656C6563746564272C2066616C7365293B0A0A2020202020202020202020202020202020202020202020202F2F2052656D6F766520636C6173730A2020202020202020202020';
wwv_flow_api.g_varchar2_table(31) := '2020202020202020202020202024706172656E742E66696E6428272E74632D73656C65637465645B646174612D7461673D272B73656C65637465645B305D2B275D27292E72656D6F7665436C617373282774632D73656C656374656427293B0A0A202020';
wwv_flow_api.g_varchar2_table(32) := '2020202020202020202020202020202020202020202F2F20506F70206669727374206172726179206D656D6265720A20202020202020202020202020202020202020202020202073656C65637465642E736869667428293B0A0A20202020202020202020';
wwv_flow_api.g_varchar2_table(33) := '202020202020202020207D0A0A202020202020202020202020202020207D0A0A2020202020202020202020207D293B0A0A20202020202020207D293B0A0A202020207D0A0A7D29286A5175657279293B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(37427044980670291736)
,p_plugin_id=>wwv_flow_api.id(37314066202881823424)
,p_file_name=>'tagcloud.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
