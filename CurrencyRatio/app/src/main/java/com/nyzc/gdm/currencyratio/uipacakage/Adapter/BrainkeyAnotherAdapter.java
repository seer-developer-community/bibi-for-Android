package com.nyzc.gdm.currencyratio.uipacakage.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.R;

import java.util.Collections;
import java.util.List;

public class BrainkeyAnotherAdapter extends BaseAdapter {
    List<String> list;
    Context context;

    public BrainkeyAnotherAdapter(List<String> lists, Context context) {
        this.context = context;
        this.list = lists;
//        Collections.reverse(list);
//        this.list = list;
    }

    public void setData(List<String> listadd) {
        this.list = listadd;
        notifyDataSetChanged();
    }

    public List<String> getData() {
        return list;
    }

    public void clearData() {
        list.clear();
        notifyDataSetChanged();

    }

    @Override
    public int getCount() {
        if (list.size() == 0) {
            return 0;
        }
        return list.size();
    }

    @Override
    public Object getItem(int i) {
        return list.get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder viewHolder;
        if (view == null) {
            view = LayoutInflater.from(context).inflate(R.layout.item_another_brainkey_layout, null);
            viewHolder = new ViewHolder(view);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
        viewHolder.brainkey.setText(list.get(i));
        return view;
    }

    public class ViewHolder {
        public final TextView brainkey;
        public final View root;

        public ViewHolder(View root) {
            brainkey = root.findViewById(R.id.tv_content_another_brainkey);
            this.root = root;
        }
    }

}
