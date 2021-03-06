<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Publication Browser</title>

   <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.1/handlebars.min.js"></script>

    <script type="text/javascript" src="/themes/cu-boulder/facetview-HTML/vendor/jquery/1.7.1/jquery-1.7.1.min.js"></script>
    <link rel="stylesheet" href="/themes/cu-boulder/facetview-HTML/vendor/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="/themes/cu-boulder/facetview-HTML/vendor/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/themes/cu-boulder/facetview-HTML/vendor/jquery-ui-1.8.18.custom/jquery-ui-1.8.18.custom.css">
    <script type="text/javascript" src="/themes/cu-boulder/facetview-HTML/vendor/jquery-ui-1.8.18.custom/jquery-ui-1.8.18.custom.min.js"></script>

    <script type="text/javascript" src="/themes/cu-boulder/facetview-HTML/es.js"></script>
    <script type="text/javascript" src="/themes/cu-boulder/facetview-HTML/bootstrap2.facetview.theme.js"></script>
    <script type="text/javascript" src="/themes/cu-boulder/facetview-HTML/jquery.facetview.js"></script>

    <link rel="stylesheet" href="/themes/cu-boulder/facetview-HTML/css/facetview.css">
    <link rel="stylesheet" href="/themes/cu-boulder/browsers.css">

   <script type='text/javascript' src='https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js?key=03b271189da4460eab0b761f3cd850fa'></script>

    <script type="text/javascript">
        jQuery(document).ready(function($) {
	    if (document.location.hostname.search("setup") !== -1) {  
                v_search_url = '/es/fis-setup-pubs/publication/_search';
	    } 
	    else 
	    { 
	      v_search_url = '/es/fispubs-v1/_search';
	    }
            $('.facet-view-simple').facetview({
                search_url: v_search_url,
                page_size: 20,
                sort: [{"publicationYear.keyword" : {"order" : "desc"}}],
                sharesave_link: true,
                search_button: true,
                default_freetext_fuzzify: "*",
                default_facet_operator: "AND",
                default_facet_order: "count",
                default_facet_size: 15,
                facets: [
                    {'field': 'mostSpecificType.keyword', 'display': 'Publication Type'},
                    {'field': 'authors.name.keyword', 'size': 20, 'display': 'Author'},
                    {'field': 'publishedIn.name.keyword', 'display': 'Published In'},
                    {'field': 'publicationYear.keyword', 'display': 'Year Published', 'sort':'desc', "size" : 25},
                    //Example of date range histogram for future // {"field": "publicationYear", "display": "Publication Year", "type" : "date_histogram", "open" : false,"sort":"desc", "size" : 25},
                    {'field': 'authors.organization.name.keyword', 'display': 'Author Organization'},
                    {'field': 'authors.researchArea.name.keyword', 'display': 'Author Research Area'},
                    {'field': 'cuscholarexists.keyword', 'display': 'Open Access'},
		    {'field': 'amscore', 'display': 'Altmetric Range', "type" : "range", "range" : [{"to" : 0.001, "display" : "0 or no value"}, {"from" : 0.001, "to" :  100, "display" : "1 - 99"}, {"from" : 100, "to" : 500, "display" : "100 - 499"}, {"from" : 500, "display" : "500+"}], 'sort':'desc', "size" : 25},
                ],
                search_sortby: [
                    {'display':'Title','field':'name.keyword'},
                    {'display':'Date','field':'publicationDate'},
                    {'display':'Altmetric Attention','field':'amscore'}
                ],
                render_result_record: function(options, record)
                {

                    var pub = record["uri"];
		    var doi = record["doi"];
                    var doiUrl = "https://dx.doi.org/"+record["doi"];
                    var escapedDOI = encodeURIComponent(doi).replace(/-/g, "--");
                    var scholarBadgeURL = "https://img.shields.io/badge/Open_Access-CU_Scholar-orange.svg?style=social&logo=open-access&logoColor=orange";
                    var doiBadgeURL = "https://img.shields.io/badge/DOI-" + escapedDOI + "-blue.svg?style=social&labelColor=black";
                    var html = "<tr><td>";

                    if (record["name"]) {
			html += "<strong><h4><a href=\""+record["uri"]+"\" target=\"_blank\" onclick=\"ga('send', 'event', 'Experts Link', this.href, 'Publication Label'); return true;\" >"+record["name"]+"</a></h4></strong>";
                    }


                    if (record["authors"]) {
                        html += "<span><small>CU Boulder Authors: ";
                        for (var i = 0; i < record["authors"].length; i++) {
			    html += "<a href=\"" + record["authors"][i]["uri"] + "\" target=\"_blank\" target=\"_blank\" onclick=\"ga('send', 'event', 'Experts Link', this.href); return true;\" >" + record["authors"][i]["name"] + "</a>";
                            if (i < record["authors"].length - 1) {
                                html += "; ";
                            }
                        }
                        html += "</small></span>";
                    }

                    if (record["subjectArea"]) {
                        html += "<br /><span>Subject Areas: ";
                        for(var i = 0; i < record["subjectArea"].length; i++) {
			    html += "<a href=\"" + record["subjectArea"][i]["uri"] + "\" target=\"_blank\" target=\"_blank\" onclick=\"ga('send', 'event', 'Experts Link', this.href); return true;\" >" + record["subjectArea"][i]["name"] + "</a>";
                            if (i < record["subjectArea"].length - 1) {
                                html += "; ";
                            }
                        }
                        html += "</span>";
                    }

                    if (record["publishedIn"]) {
			html += "<br /><span>Published in: <a href=\""+record["publishedIn"]["uri"]+"\" target=\"_blank\" target=\"_blank\" onclick=\"ga('send', 'event', 'Experts Link', this.href); return true;\" >"+record["publishedIn"]["name"]+"</a></span>";
                    }


                    html += "<br />";
                    if (record["publicationDate"]) {
                        html += "Publication Date: " + record["publicationDate"] + "         ";
                    }

                    html += "<br />";
                    if (record["mostSpecificType"]) {
                        html += "Type: " + record["mostSpecificType"];
                    }


                    if (record["presentedAt"]) {
                        html += "<br /><span>Presented at: <a href=\""+record["presentedAt"]["uri"]+"\" target=\"_blank\">"+record["presentedAt"]["name"]+"</a></span>";
                    }

                    // Badges

                    html += "<br><div class='badge'>"

                    html += "<div style=\"padding-right: 4px\">"
                    if (record["doi"]) {
			html += "<br /><span><a href=\""+doiUrl+"\" target=\"_blank\" target=\"_blank\" onclick=\"ga('send', 'event', 'DOI Link', this.href); return true;\" ><img src=" + doiBadgeURL + "></a></span>";
                    } 
                    html += "</div>"

                    html += "<div>"
                    if (record["cuscholar"]) {
		        html += "<span><a href=\""+record["cuscholar"]+"\" target=\"_blank\" target=\"_blank\" onclick=\"ga('send', 'event', 'CU Scholar Link', this.href); return true;\" ><img src=" + scholarBadgeURL + "></a></span>";
                    } 
                    html += "</div>"

		    html += "<div class='altmetric-embed' data-link-target='_blank' onclick=\"ga('send','event','Altmetric Link', '" + pub + "'); return true;\" data-hide-no-mentions='true' data-badge-popover='left' data-doi=\""+record["doi"]+"\"></div>"

                    html += "</div>"

                    html += "</td></tr>";
                    return html;
                },
                selected_filters_in_facet: true,
                show_filter_field : true,
                show_filter_logic: true,
            });
        });

    </script>

    <style type="text/css">


        .facet-view-simple{
            width:100%;
            height:100%;
            margin:20px auto 0 auto;
        }

        .facetview_freetext.span4 {
           width: 290px;
           height: 12px;
        }

        legend {
           display: none;
        }

        #wrapper-content {
          padding-top: 0px;
        }

        input {
            -webkit-box-shadow: none;
            box-shadow: none;
        }
        
        .alert {
           margin-top: 20px; 
        }

        .badge a {
           float: left;
           display: inline;
           padding-right: 5px;
           padding-top: 10px;
        }

    </style>

</head>
<body>
<div class="facet-view-simple"></div>
</body>
</html>
