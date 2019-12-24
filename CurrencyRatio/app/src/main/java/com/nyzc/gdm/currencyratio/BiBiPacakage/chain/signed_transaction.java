package com.nyzc.gdm.currencyratio.BiBiPacakage.chain;




import com.nyzc.gdm.currencyratio.BiBiPacakage.common.compact_signature;
import com.nyzc.gdm.currencyratio.BiBiPacakage.fc.crypto.sha256_object;
import com.nyzc.gdm.currencyratio.BiBiPacakage.types;

import java.util.ArrayList;
import java.util.List;


public class signed_transaction extends transaction {
    List<compact_signature> signatures = new ArrayList<>();

    public void sign(types.private_key_type privateKeyType, sha256_object chain_id) {
        sha256_object digest = sig_digest(chain_id);
        signatures.add(privateKeyType.getPrivateKey().sign_compact(digest, true));

    }
}
