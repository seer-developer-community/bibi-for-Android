package com.nyzc.gdm.currencyratio.uipacakage;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;

import com.nyzc.gdm.currencyratio.R;
import com.nyzc.gdm.currencyratio.Utils.CacheUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class StartPage extends AppCompatActivity {
    ViewPager startViewpager;
    List<View> mViewList;
    String is_first_enter;
    TextView at_once_enter;
    String language;
    LayoutInflater lf;
    ImageView imageView1, imageView2, imageView3;

    /**
     * 进入引导页时 先获取系统语言，根据系统语言展示相对应的values文件下的内容
     * en 代表英文  zh代表中文
     * @param savedInstanceState
     */
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_start_page);
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.hide();
        }
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        Locale locale = Locale.getDefault();
        language = locale.getLanguage();
        startViewpager = findViewById(R.id.start_viewpager);
        at_once_enter = findViewById(R.id.at_once_enter);
        is_first_enter = CacheUtils.getString(StartPage.this, "is_first_enter", "");
        if (is_first_enter == null || is_first_enter.equals("")) {
            CacheUtils.putString(StartPage.this, "is_first_enter", "gdm");
            mViewList = new ArrayList<View>();
            lf = getLayoutInflater().from(StartPage.this);
            View view1 = lf.inflate(R.layout.we_indicator1, null);
            View view2 = lf.inflate(R.layout.we_indicator2, null);
            View view3 = lf.inflate(R.layout.we_indicator3, null);
            imageView1 = view1.findViewById(R.id.start_one);
            imageView2 = view2.findViewById(R.id.start_two);
            imageView3 = view3.findViewById(R.id.start_three);
            if (language.equals("zh")) {
                at_once_enter.setText("开始体验");
                CacheUtils.putString(StartPage.this, "langauage", "zh");
                imageView1.setImageDrawable(getResources().getDrawable(R.mipmap.start_one));
                imageView2.setImageDrawable(getResources().getDrawable(R.mipmap.start_two));
                imageView3.setImageDrawable(getResources().getDrawable(R.mipmap.start_three));
            } else {
                at_once_enter.setText("Start");
                CacheUtils.putString(StartPage.this, "langauage", "en");
                imageView1.setImageDrawable(getResources().getDrawable(R.mipmap.en_start_one));
                imageView2.setImageDrawable(getResources().getDrawable(R.mipmap.en_two_start));
                imageView3.setImageDrawable(getResources().getDrawable(R.mipmap.en_three_start));
            }
            mViewList.add(view1);
            mViewList.add(view2);
            mViewList.add(view3);
            startViewpager.setAdapter(new ViewPagerAdatper(mViewList));
        } else {
            startActivity(new Intent(StartPage.this, SplashActivity.class));
            finish();
        }

        startViewpager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
                if (startViewpager.getCurrentItem() == startViewpager.getAdapter().getCount() - 1) {
                    at_once_enter.setVisibility(View.VISIBLE);
                } else {
                    at_once_enter.setVisibility(View.GONE);
                }
            }

            @Override
            public void onPageSelected(int position) {
            }

            @Override
            public void onPageScrollStateChanged(int state) {
            }
        });
        at_once_enter.setOnClickListener(v -> {
            startActivity(new Intent(StartPage.this, SplashActivity.class));
            finish();
        });
    }

    public class ViewPagerAdatper extends PagerAdapter {
        private List<View> mViewList;

        public ViewPagerAdatper(List<View> mViewList) {
            this.mViewList = mViewList;
        }

        @Override
        public int getCount() {
            return mViewList.size();
        }

        @Override
        public boolean isViewFromObject(View view, Object object) {
            return view == object;
        }

        @Override
        public Object instantiateItem(ViewGroup container, int position) {
            container.addView(mViewList.get(position));
            return mViewList.get(position);
        }

        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            container.removeView(mViewList.get(position));
        }
    }

}
