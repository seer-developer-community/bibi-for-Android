package com.nyzc.gdm.currencyratio.OrderPacakage.Adapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import java.util.List;

public class ViewPagerFragmentAdapter extends FragmentPagerAdapter {

    private List<Fragment> mList ;
    private List<String> mTitleList ;
    public ViewPagerFragmentAdapter(FragmentManager fm, List<Fragment> list,List<String> titleList) {
        super(fm);
        this.mList = list;
        this.mTitleList=titleList;
    }

    @Override
    public Fragment getItem(int position) {
        return mList.get(position);
    }

    @Override
    public int getCount() {
        return mList != null ? mList.size() : 0;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        return mTitleList.get(position);
    }
}
