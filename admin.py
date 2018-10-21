import logging

from django.contrib import admin
from django.contrib.sites.shortcuts import get_current_site
from django.core.management import call_command
from django.http import FileResponse
from django.utils.html import format_html

from tucat.twitter_extraction.models import TwitterListExtraction, TwitterListExtractionExport, ExportationType, ExportationFormat, ExtractionCollection


logger = logging.getLogger('application')

def run(modeladmin, request, queryset):
    logger.info('Command run %s %s', request, queryset)

    for obj in queryset:
        logger.debug('Command export run %s', obj)
        call_command('export', obj=obj, run='run')
run.short_description = "Run the export"

def stop(modeladmin, request, queryset):
    logger.info('Command run %s %s', request, queryset)

    for obj in queryset:
        logger.debug('Command export stop %s', obj)
        call_command('export', obj=obj, stop='stop')
stop.short_description = "Stop the export"

def download(modeladmin, request, queryset):

    site = str(get_current_site(request))
    for obj in queryset:
        try:
            logger.debug('Command export download for %s', str(obj.file) )
            response = FileResponse(obj.file, as_attachment=True)

            return response
        except Exception as e:
            logger.exception(e)

download.short_description = "Download this export file (one at a time)"


class TwitterListExtractionAdmin(admin.ModelAdmin):
    list_display = ('owner_name', 'list_name', 'status', 'modified', 'is_enabled')
    readonly_fields = ('modified', 'status')


class TwitterListExtractionExportAdmin(admin.ModelAdmin):
    readonly_fields = ('task_id', 'status', 'link_file', 'file')
    list_display = ('name', 'collection', 'export_type', 'export_format', 'last_tweet', 'task_id', 'status', 'download')
    actions = [run, stop, download]

    class Media:
        # Adds the js script to the HTML admin view
        # https://docs.djangoproject.com/en/2.1/topics/forms/media/
        js = ("js/project.js",)

    def download(self, obj):
        button_html = '<button type="submit" class="button" type="button" onclick="download_file(%d)">Download</button>' % obj.id
        return format_html(button_html)


class ExtractionCollectionAdmin(admin.ModelAdmin):
    list_display = ('owner_name', 'list_name', 'completed')


admin.site.register(TwitterListExtraction, TwitterListExtractionAdmin)
admin.site.register(TwitterListExtractionExport, TwitterListExtractionExportAdmin)
admin.site.register(ExportationFormat)
admin.site.register(ExportationType)
admin.site.register(ExtractionCollection, ExtractionCollectionAdmin)
