package cy.agorise.graphenej.Bean;

import java.io.Serializable;
import java.util.List;

public class RoomParamBean implements Serializable {


    /**
     * id : 11
     * method : get_houses
     * params : [["1.14.2","1.14.1","1.14.0"]]
     */

    private int id;
    private String method;
    private List<List<String>> params;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public List<List<String>> getParams() {
        return params;
    }

    public void setParams(List<List<String>> params) {
        this.params = params;
    }
}
