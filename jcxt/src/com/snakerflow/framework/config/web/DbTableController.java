package com.snakerflow.framework.config.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.snakerflow.framework.config.entity.Field;
import com.snakerflow.framework.config.entity.Form;
import com.snakerflow.framework.config.service.DynamicFormManager;
import com.snakerflow.framework.orm.Page;
import com.snakerflow.framework.orm.PropertyFilter;

/**
 * 动态表单管理Controller
 * @author yuqs
 * @since 0.1
 */
@Controller
@RequestMapping(value = "/config/dbtable")
public class DbTableController {

    @Autowired
    private DynamicFormManager dynamicFormManager;

    @RequestMapping( method = RequestMethod.GET)
    public String list(Model model, Page<Form> page, HttpServletRequest request) {
        List<PropertyFilter> filters = PropertyFilter.buildFromHttpRequest(request);
        //设置默认排序方式
        if (!page.isOrderBySetted()) {
            page.setOrderBy("id");
            page.setOrder(Page.ASC);
        }
        page = dynamicFormManager.findPage(page, filters);
        model.addAttribute("page", page);
        return "config/dbTableList";
    }
    @RequestMapping(value = "{formid}", method = RequestMethod.GET)
    public String viewTable(@PathVariable("formid") Long formid,Model model) {
        Form form=dynamicFormManager.get(formid);
        List<Field> fields = dynamicFormManager.getFields(formid);
        model.addAttribute("form", form);
        model.addAttribute("fields", fields);
        return "config/fieldList";
    }
    @RequestMapping(value = "template/{formid}", method = RequestMethod.GET)
    public String viewTemplate(@PathVariable("formid") Long formid, String orderId,Model model) {
        Form form=dynamicFormManager.get(formid);
        System.out.println("**********"+form.getDisplayName());
        List<Map<String, Object>> datas = dynamicFormManager.getDatasByOrderId(form, orderId);
        List<Field> fields=dynamicFormManager.getFields(form.getId());
        model.addAttribute("form", form);
        model.addAttribute("fields", fields);
        model.addAttribute("datas", datas);
        return "config/templates";
    }
}
