package com.wyest.pw.jsf;

import com.wyest.pw.model.CustomerLoadProfile;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import java.io.ByteArrayInputStream;
import java.io.InputStream;

import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 7/6/13
 * Time: 10:22 PM
 */
@ManagedBean
@ViewScoped
public class FileDownloadController {
    private static Logger log = LoggerFactory.getLogger(FileDownloadController.class);

    private StreamedContent file;

    public FileDownloadController() {
        log.info("new instance created");
    }

    public void fileDownloadAction(CustomerLoadProfile loadProfile) {
        if (notEmpty(loadProfile)) {
            byte[] data = loadProfile.getFileData();
            InputStream stream = new ByteArrayInputStream(data);
            file = new DefaultStreamedContent(stream, loadProfile.getContentType(), loadProfile.getFileName());
        }
    }

    public StreamedContent getFile() {
        return file;
    }
}
