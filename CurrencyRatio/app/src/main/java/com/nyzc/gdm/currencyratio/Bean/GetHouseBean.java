package com.nyzc.gdm.currencyratio.Bean;

import java.io.Serializable;
import java.util.List;

public class GetHouseBean implements Serializable {

        private String id;
        private String owner;
        private String description;
        private String script;
        private double reputation;
        private String guaranty;
        private double volume;
        private double collected_fees;
        private List<String> rooms;
        private List<String> finished_rooms;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getOwner() {
            return owner;
        }

        public void setOwner(String owner) {
            this.owner = owner;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getScript() {
            return script;
        }

        public void setScript(String script) {
            this.script = script;
        }

        public double getReputation() {
            return reputation;
        }

        public void setReputation(double reputation) {
            this.reputation = reputation;
        }

        public String getGuaranty() {
            return guaranty;
        }

        public void setGuaranty(String guaranty) {
            this.guaranty = guaranty;
        }

        public double getVolume() {
            return volume;
        }

        public void setVolume(double volume) {
            this.volume = volume;
        }

        public double getCollected_fees() {
            return collected_fees;
        }

        public void setCollected_fees(double collected_fees) {
            this.collected_fees = collected_fees;
        }

        public List<String> getRooms() {
            return rooms;
        }

        public void setRooms(List<String> rooms) {
            this.rooms = rooms;
        }

        public List<String> getFinished_rooms() {
            return finished_rooms;
        }

        public void setFinished_rooms(List<String> finished_rooms) {
            this.finished_rooms = finished_rooms;
        }

}
