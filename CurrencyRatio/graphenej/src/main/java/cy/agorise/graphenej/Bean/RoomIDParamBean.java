package cy.agorise.graphenej.Bean;

import java.io.Serializable;
import java.util.List;

public class RoomIDParamBean implements Serializable {


    /**
     * id : 11
     * method : get_seer_room
     * params : ["1.15.89",0,100]
     */

    private int id;
    private String method;
    private List<Object> params;

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

    public List<Object> getParams() {
        return params;
    }

    public void setParams(List<Object> params) {
        this.params = params;
    }
}
