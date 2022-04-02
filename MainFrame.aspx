<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainFrame.aspx.cs" Inherits="Web_Portal.MainFrame" Debug="true"%>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <%--  <script src="http://localhost:8080/geoserver/openlayers3/ol.js" type="text/javascript"></script>
    <link rel="stylesheet" href="http://localhost:8080/geoserver/openlayers3/ol.css" />--%>

  <%--   <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.12.0/build/ol.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.12.0/css/ol.css" type="text/css">--%>

    <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.12.0/build/ol.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.12.0/css/ol.css"/>


    <link rel = "stylesheet" type = "text/css" href = "https://cdnjs.cloudflare.com/ajax/libs/extjs/6.2.0/classic/theme-crisp/resources/theme-crisp-all.css" / >
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/extjs/6.2.0/ext-all.js"> </script>

    <link rel="stylesheet" type ="text/css" href="Styles/General2.css" />
    <style>
    #TopPanel {
        display: inline-flex;
        margin: auto;
        position: absolute;
        height: 37px;
        inset: 0px 0px auto;
        box-shadow: 0px 1px 8px 0px rgb(0 0 0 / 40%);
        background-color: rgba(72, 85, 102, 0.9);
    }
    #ListLayersButton {
        height:40px;
        width:40px;
        cursor: pointer;
        opacity: 1;
        margin-left: auto;
    }
    .ListLayersButton_clicked {
        background-color: rgba(0, 0, 0, 0.3);
        border: none;
        border-top: 2px solid #8491a1;
    }
    #ListLayerPanel {
        inset: 35px 5px 5px auto;
        width: 360px;
        height: 0px;
        padding: 0px;
        /*margin: auto;*/
        z-index: 101;
        position: absolute;
        opacity: 1;
        border-radius: 4px;
        display: none;
    }
    #Head_bar {
        color: white;
        cursor: pointer;
        background-color: #485566;
        box-shadow: 0px 1px 4px 0px rgb(0 0 0 / 40%);
        font-weight: bold;
        display: flex;
    }
    #Panel_Header
    {
        height: 100%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        flex-grow: 1;
        padding: 0 10px;
        margin: 0;
        font-size: 16px;
    }
    #btns-container
    {
        min-width: 70px;
        max-width: 105px;
        flex-grow: 0;
        display: flex;
        height: calc(100% - 4px);
        margin-top: 2px;
        margin-right: 2px;
    }
    .layer_panel_header_btn
    {
        width: 35px;
        height: 100%;
        border-radius: 11px;
        opacity: 1;
        background-position: center;
        background-repeat: no-repeat;
    }
    #Panel_content {
        position: absolute;
        left: 0;
        right: 0;
        /*bottom: 0;*/
        overflow-x: hidden;
        overflow-y: auto;
        background-color: white;
    }
    #layer_list_table {
        width: 100%;
        border-spacing: 0px;
        border: 0px solid #999;
    }
    .chk_box {
        display: inline-flex;
        flex-grow: 0;
        flex-shrink: 0;
        flex-basis: 16px;
        width: 16px;
        height: 16px;
        cursor: pointer;
        border-radius: 2px;

        margin-left: 15px;
    }
    .col1 {
        width: 50px;
    }

    #toolbar_my
    {
        position: absolute;
        top: 104px;
        right: 9px;
        box-shadow: none;
        opacity: 1;
        width: 38px;
        height: 120px;
        border-radius: 0;
        border: solid 1px rgba(0, 0, 0, 0.15);
        z-index: 1000;
    }
    .toolbar_btn {
        height: 38px;
        width: 38px;
    }
    /*.Measure_btns2 {
        inset: 4px auto auto 40px;
        width: 40px;
        height: 40px;
        padding: 0px;
        margin: auto;
        z-index: 1000;
        position: absolute;
        background-color: #555;
        border: 1px solid #999;
        border-radius: 4px;
        cursor:pointer;
        display: contents;
    }*/
    .Measure_btns {
        background-color: #fff;
        width: 150px;
        height: 38px;
        box-sizing: border-box;
        border-bottom: solid 1px #e0e0e0;
        box-shadow: none;
        position: relative;
        -webkit-border-radius: 0;
        border-radius: 0;
        cursor: pointer;
        line-height: 40px;
        color: #000000;
        text-align: center;
        z-index: 1000;

    }
    .Measure_btn_clicked {
        color: blue;
    }
    #Measurement_menu {
        position: fixed;
        right: 10px;
        right: 48px !important;
        border-radius: 0;
        border: 1px solid rgba(0, 0, 0, 0.15);
        width: 150px;
        background-color: #f5f5f5;
        cursor: default;
        opacity: 1;
    }

    .dropdown-content {
        display: none;
    }
    .dropdown:hover .dropdown-content {display: block;}

    .dropdown-content div:hover {background-color: #ddd;}

    .LabelLines {
        height: 20px;
        width: 100px;
        margin-left: 45px;
        position: fixed;
        margin-top: 10px;
        text-align: start;
        font: 14px/1.5 'PT Sans', sans-serif;
        -webkit-user-select: none;
        pointer-events: none;
    }
    .LabelImages {
        background-repeat: no-repeat;
        background-position: center;
        height: 38px;
        width: 38px;
        position: absolute;
        cursor: pointer;
    }
    .txtCoordinates {
        margin-top:12px;
        margin-bottom:12px;
        padding-right:10px;
        user-select: text;
        cursor: text;
    }
    .change_coords_btn {
        width:18px;
        height:18px;
        margin-top: 10px;
        background-image:url(Icons/Change.png);
        background-repeat:no-repeat;
        background-position:center;
        cursor: pointer;
        background-size: contain;
    }
    .copybutton {
        width: 18px;
        height: 18px;
        margin-top: 10px;
        margin-left: 5px;
        background-image: url(Icons/copy_button.png);
        background-repeat: no-repeat;
        background-position: center;
        cursor: pointer;
        background-size: contain;
    }

    </style>
    <style>
        /*.ol-tooltip {
          position: relative;
          background: rgba(0, 0, 0, 0.5);
          border-radius: 4px;
          color: white;
          padding: 4px 8px;
          opacity: 0.7;
          white-space: nowrap;
          font-size: 12px;
          cursor: default;
          user-select: none;
        }
        .ol-tooltip-measure {
          opacity: 1;
          font-weight: bold;
        }
        .ol-tooltip-static {
          background-color: #ffcc33;
          color: black;
          border: 1px solid white;
        }
        .ol-tooltip-measure:before,
        .ol-tooltip-static:before {
          border-top: 6px solid rgba(0, 0, 0, 0.5);
          border-right: 6px solid transparent;
          border-left: 6px solid transparent;
          content: "";
          position: absolute;
          bottom: -6px;
          margin-left: -7px;
          left: 50%;
        }
        .ol-tooltip-static:before {
          border-top-color: #ffcc33;
        }*/
    </style>

    <style>
    .SearchContainer_active {
        background-image: url(Icons/Search_light.svg) !important;
    }
    </style>
    <link rel="stylesheet" type ="text/css" href="Styles/Search5.css" />
    <link rel="stylesheet" type ="text/css" href="Styles/Measure3.css" />
    <style>
        .x-grid-item {
            color: #000;
            font: 200 12px/9px helvetica, arial, verdana, sans-serif;
            background-color: #fff;
        }
    </style>

    <style>
        /*#SidePanel {
           width: 300px;
            height: 835px;
            background: white;
            position: absolute;
            z-index: 2;
            text-align: center;
            border: ridge;
            transition: 0.5s;
        }*/

        #Hide_SidePanel_btn {
            position: absolute;
            margin-left: 310px;
            margin-top: 10px;
            height: 35px;
            width: 35px;
            background: transparent;
            cursor: pointer;
            z-index: 1;
            transition: 0.5s;
        }

        .sidenav {
            height: 100%;
            width: 305px;
            position: fixed;
            z-index: 1;
            background-color: white;
            overflow-x: hidden;
            transition: 0.5s;
        }
            .sidenav a {
                padding: 8px 8px 8px 32px;
                text-decoration: none;
                font-size: 25px;
                color: #818181;
                display: block;
                transition: 0.3s;
            }
    </style>
</head>
<body onload="CreateXMLHttpRequest()">
<%--    <form id="form1" runat="server">--%>
    <asp:Panel ID="TopPanel" runat="server" Width="100%">
        <div id="ListLayersButton" role="button" title="Список слоев" onclick="OpenLayersPanel()">
            <img src="Icons/Layers.png" height="24" width="24" style="margin-top:6px; margin-left:8px;" />
        </div>
        <div id="SearchContainer" class="search-container">
           <%-- <div id="Search_HeadBar" class="Search_HeadBar"></div>--%>
            <div role="button" class="search_btn" style="border-radius: 4px 0 0 4px; background-image: url(Icons/down-arrow2.png);" onclick="OpenSearchMenu()"></div>
            <form id="search_form"></form>
            <div id="SearchIcon" role="button" class="search_btn" style="border-radius: 0 4px 4px 0; background-image: url(Icons/Search.svg);"></div>
            <div id="SearchMenu" style="height:0px;">
                <ul role="menu" id="SearchItems" style="width: 240px;">
                    <li data-index="0" id="GMMIR.V_BUILD" role="menuitem" class="active" tabindex="0" onclick="ChangeActiveMenuItem(event.target)">ТОСы</li>
                    <li data-index="1" role="menuitem" class="" tabindex="0" onclick="ChangeActiveMenuItem(event.target)">Земельные участки</li>
                </ul>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="ListLayerPanel" runat="server">
        <div id="Head_bar" style="height:37px; width:100%">
            <h2 id="Panel_Header" title="Список слоев" style="line-height:32px;">Список слоёв</h2>
            <div id="btns-container">
                <div role="button" id ="foldable-btn" class="layer_panel_header_btn" onclick="HideLayersPanel(event)">
                    <img src="Icons/fold_up.png" style="margin-top:10px; margin-left:10px;"/>
                </div>
                <div role="button" id ="close-btn" class="layer_panel_header_btn" onclick="OpenLayersPanel()">
                    <img src="Icons/x.png" style="margin-top:10px; margin-left: 10px;" />
                </div>
            </div>
        </div>
        <div id ="Panel_content" style=" display:unset;" draggable="true">
            <table id="layer_list_table">
                <tbody>
                    <tr class="layer" style="height:40px; display:none">
                        <td class="col col1">
                            <input class="chk_box" type="checkbox" value="Название слоя" checked="checked" onchange="Show_selected_layers(event)"/>
                        </td>
                        <td class="col col2">
                            <div>Название слоя</div>
                        </td>
                        <td class="col col3"></td>
                    </tr>
                </tbody>
            </table>
            </div>
    </asp:Panel>
    
     <div id="map">
         <div id="toolbar_my">
             <div id="Measurement_btn" role="button" class="toolbar_btn dropdown" style="background-color: white; margin: auto;">
                 <div id="Reset_btn" class="LabelImages" style="background-image: url(Icons/measurement.svg);" onclick="Reset_measure(event.target)"></div>
                 <div id="Measurement_menu" class="dropdown-content">
                     <div id="distance" class="Measure_btns" role="button" onclick="Clicked(event.target)">
                         <div class="LabelImages" style="background-image: url(Icons/distance.svg); pointer-events: none;"></div>
                         <div class="LabelLines">Расстояние</div>
                     </div>
                     <div id="area" class="Measure_btns" role="button" onclick="Clicked(event.target)">
                         <div class="LabelImages" style="background-image: url(Icons/area.svg); pointer-events: none;"></div>
                         <div class="LabelLines">Площадь</div>
                     </div>
                     <div id="point" class="Measure_btns" role="button" onclick="Clicked(event.target)">
                         <div class="LabelImages" style="background-image: url(Icons/point.svg); pointer-events: none;"></div>
                         <div class="LabelLines">Координата</div>
                     </div>
                 </div>
             </div>
            <%-- <div id="Search_btn" role="button" class="toolbar_btn dropdown" style="background-color: white; margin: auto;">
                 <div id="Search" class="LabelImages" style="background-image: url(Icons/Search.svg);" onclick="OpenSearchPanel()"></div>
                 <div id="SearchContainer" class="search-container">
                     <div id="Search_HeadBar" class="Search_HeadBar"></div>
                     <div role="button" class="search_btn" style="border-radius: 4px 0 0 4px; background-image: url(Icons/down-arrow2.png); margin-left: -34px; margin-top: 1px; position: absolute;" onclick="OpenSearchMenu()"></div>
                     <form id="search_form"></form>
                     <div id="SearchIcon" role="button" class="search_btn" style="border-radius: 0 4px 4px 0; background-image: url(Icons/Search.svg); margin-left: 170px; margin-top: 1px; position: absolute;"></div>
                     <div id="SearchMenu" style="display: none;">
                         <ul role="menu" id="SearchItems" style="width: 238px;">
                             <li data-index="0" id="GMMIR.V_BUILD" role="menuitem" class="active" tabindex="0" onclick="ChangeActiveMenuItem(event.target)">ТОСы</li>
                             <li data-index="1" role="menuitem" class="" tabindex="0" onclick="ChangeActiveMenuItem(event.target)">Земельные участки</li>
                         </ul>
                     </div>
                 </div>
             </div>--%>
         </div>

         <div id="SidePanel" class="sidenav">
             <a href="#" style="margin-top: 5px; margin-bottom: 5px; width: 260px;">Выбранный объект </a>
             <div id="GridPanel_container"></div>
         </div>
         <div id="Hide_SidePanel_btn" role="button" onclick="HideOpen_SidePanel()">
             <img src="Icons/left_arrow.svg" height="35" width="35" />
         </div>
    </div>

   <script src="JavaScript/MapFunctions.js"></script>
    <script>
        var new_Style = new ol.style.Style({
            image: new ol.style.Icon({
                anchor: [0.5, 0.96],
                crossOrigin: 'anonymous',
                src: "Icons/Pin_image.png",
                img: null,
                imgSize: null,
            })
        })

        var pin_layer = new ol.layer.Vector({
            source: new ol.source.Vector({
                features: [
                    //new ol.Feature({
                    //    geometry: new ol.geom.Point(object.getGeometry().getFlatInteriorPoint())
                    //})
                ]
            }),
            style: new_Style,
        });
        pin_layer.setMap(map);

        // GetObject("TERR_SELF_GOVERNMENT", 9, "blue")
        var last_selected_object;

        function GetObject(Layer_Name, object_id, highlight_color) {

            var object_found = false;
            if (last_selected_object) last_selected_object.setStyle(null);

            map.getLayers().forEach(function (layer) {
                var layer_source_name = layer.get("layer_source_name"); // TERR_SELF_GOVERNMENT

                if (layer_source_name == Layer_Name && layer.getVisible()) { // Проверка на то, что такой слой есть, и он видим на карте
                    var object = layer.getSource().getFeatureById(layer_source_name + "." + object_id);

                    if (object) { // Проверка на то, что объект найден

                        if (object == selected_feature) selectSingleClick.getFeatures().clear(); // Сброс выделения, если найденные объект уже выделен //selectSingleClick в FeatureInfo.js

                        last_selected_object = object;

                        var selected_style = new ol.style.Style({
                            fill: new ol.style.Fill({
                                color: highlight_color,
                            })
                        });

                        object.setStyle(selected_style);
                        FeatureInfo2(object.getGeometry().getFlatInteriorPoint()) //FeatureInfo2 - функция из FeatureInfo.js
                        map.getView().fit(object.getGeometry());


                        var feature = new ol.Feature({
                            geometry: new ol.geom.Point(object.getGeometry().getFlatInteriorPoint()),
                            name: 'My Polygon'
                        });
                        pin_layer.getSource().addFeature(feature);


                        object_found = true;
                    }
                    else alert("Объект " + Layer_Name + "." + object_id + " не найден");
                }
            })
            if (object_found == false) alert("Включите отображение слоя");
        }
        //ol.extent.getCenter( last_selected_object.getGeometry().getExtent())
    </script>

    <script src="JavaScript/FeatureInfo4.js"></script>
    <script src="JavaScript/Search4.js"></script>
    <script src="JavaScript/htmlElements_handler2.js"></script>
    <script src="JavaScript/Measure4.js"></script>
</body>
</html>
