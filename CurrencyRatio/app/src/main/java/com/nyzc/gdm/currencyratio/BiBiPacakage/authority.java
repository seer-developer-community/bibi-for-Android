package com.nyzc.gdm.currencyratio.BiBiPacakage;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class authority implements Serializable {
    private Integer weight_threshold;
    public HashMap<object_id<account_object>, Integer> account_auths = new HashMap<>();
    private HashMap<types.public_key_type, Integer> key_auths = new HashMap<>();
    private HashMap<address, Integer> address_auths = new HashMap<>();

    public authority(int nWeightThreshold, types.public_key_type publicKeyType, int nWeightType) {
        weight_threshold = nWeightThreshold;
        key_auths.put(publicKeyType, nWeightType);
    }

    public boolean is_public_key_type_exist(types.public_key_type publicKeyType) {
        return key_auths.containsKey(publicKeyType);
    }

    public List<types.public_key_type> get_keys() {
        List<types.public_key_type> listKeyType = new ArrayList<>();
        listKeyType.addAll(key_auths.keySet());
        return listKeyType;
    }

    public Integer getWeight_threshold() {
        return weight_threshold;
    }

    public void setWeight_threshold(Integer weight_threshold) {
        this.weight_threshold = weight_threshold;
    }

    public HashMap<object_id<account_object>, Integer> getAccount_auths() {
        return account_auths;
    }

    public void setAccount_auths(HashMap<object_id<account_object>, Integer> account_auths) {
        this.account_auths = account_auths;
    }

    public HashMap<types.public_key_type, Integer> getKey_auths() {
        return key_auths;
    }

    public void setKey_auths(HashMap<types.public_key_type, Integer> key_auths) {
        this.key_auths = key_auths;
    }

    public HashMap<address, Integer> getAddress_auths() {
        return address_auths;
    }

    public void setAddress_auths(HashMap<address, Integer> address_auths) {
        this.address_auths = address_auths;
    }

    @Override
    public String toString() {
        return "authority{" +
                "weight_threshold=" + weight_threshold +
                ", account_auths=" + account_auths +
                ", key_auths=" + key_auths +
                ", address_auths=" + address_auths +
                '}';
    }
}
