open Prims
type env =
  {
  env: FStar_TypeChecker_Env.env;
  subst: FStar_Syntax_Syntax.subst_elt Prims.list;
  tc_const: FStar_Const.sconst -> FStar_Syntax_Syntax.typ;}[@@deriving show]
let __proj__Mkenv__item__env: env -> FStar_TypeChecker_Env.env =
  fun projectee  ->
    match projectee with
    | { env = __fname__env; subst = __fname__subst;
        tc_const = __fname__tc_const;_} -> __fname__env
let __proj__Mkenv__item__subst:
  env -> FStar_Syntax_Syntax.subst_elt Prims.list =
  fun projectee  ->
    match projectee with
    | { env = __fname__env; subst = __fname__subst;
        tc_const = __fname__tc_const;_} -> __fname__subst
let __proj__Mkenv__item__tc_const:
  env -> FStar_Const.sconst -> FStar_Syntax_Syntax.typ =
  fun projectee  ->
    match projectee with
    | { env = __fname__env; subst = __fname__subst;
        tc_const = __fname__tc_const;_} -> __fname__tc_const
let empty:
  FStar_TypeChecker_Env.env ->
    (FStar_Const.sconst -> FStar_Syntax_Syntax.typ) -> env
  = fun env  -> fun tc_const  -> { env; subst = []; tc_const }
let gen_wps_for_free:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.binders ->
      FStar_Syntax_Syntax.bv ->
        FStar_Syntax_Syntax.term ->
          FStar_Syntax_Syntax.eff_decl ->
            (FStar_Syntax_Syntax.sigelts,FStar_Syntax_Syntax.eff_decl)
              FStar_Pervasives_Native.tuple2
  =
  fun env  ->
    fun binders  ->
      fun a  ->
        fun wp_a  ->
          fun ed  ->
            let wp_a1 =
              FStar_TypeChecker_Normalize.normalize
                [FStar_TypeChecker_Normalize.Beta;
                FStar_TypeChecker_Normalize.EraseUniverses] env wp_a in
            let a1 =
              let uu___290_93 = a in
              let uu____94 =
                FStar_TypeChecker_Normalize.normalize
                  [FStar_TypeChecker_Normalize.EraseUniverses] env
                  a.FStar_Syntax_Syntax.sort in
              {
                FStar_Syntax_Syntax.ppname =
                  (uu___290_93.FStar_Syntax_Syntax.ppname);
                FStar_Syntax_Syntax.index =
                  (uu___290_93.FStar_Syntax_Syntax.index);
                FStar_Syntax_Syntax.sort = uu____94
              } in
            let d s = FStar_Util.print1 "\027[01;36m%s\027[00m\n" s in
            (let uu____102 =
               FStar_TypeChecker_Env.debug env (FStar_Options.Other "ED") in
             if uu____102
             then
               (d "Elaborating extra WP combinators";
                (let uu____104 = FStar_Syntax_Print.term_to_string wp_a1 in
                 FStar_Util.print1 "wp_a is: %s\n" uu____104))
             else ());
            (let rec collect_binders t =
               let uu____116 =
                 let uu____117 =
                   let uu____120 = FStar_Syntax_Subst.compress t in
                   FStar_All.pipe_left FStar_Syntax_Util.unascribe uu____120 in
                 uu____117.FStar_Syntax_Syntax.n in
               match uu____116 with
               | FStar_Syntax_Syntax.Tm_arrow (bs,comp) ->
                   let rest =
                     match comp.FStar_Syntax_Syntax.n with
                     | FStar_Syntax_Syntax.Total (t1,uu____151) -> t1
                     | uu____160 -> failwith "wp_a contains non-Tot arrow" in
                   let uu____163 = collect_binders rest in
                   FStar_List.append bs uu____163
               | FStar_Syntax_Syntax.Tm_type uu____174 -> []
               | uu____179 -> failwith "wp_a doesn't end in Type0" in
             let mk_lid name = FStar_Syntax_Util.dm4f_lid ed name in
             let gamma =
               let uu____197 = collect_binders wp_a1 in
               FStar_All.pipe_right uu____197 FStar_Syntax_Util.name_binders in
             (let uu____217 =
                FStar_TypeChecker_Env.debug env (FStar_Options.Other "ED") in
              if uu____217
              then
                let uu____218 =
                  let uu____219 =
                    FStar_Syntax_Print.binders_to_string ", " gamma in
                  FStar_Util.format1 "Gamma is %s\n" uu____219 in
                d uu____218
              else ());
             (let unknown = FStar_Syntax_Syntax.tun in
              let mk1 x =
                FStar_Syntax_Syntax.mk x FStar_Pervasives_Native.None
                  FStar_Range.dummyRange in
              let sigelts = FStar_Util.mk_ref [] in
              let register env1 lident def =
                let uu____245 =
                  FStar_TypeChecker_Util.mk_toplevel_definition env1 lident
                    def in
                match uu____245 with
                | (sigelt,fv) ->
                    ((let uu____253 =
                        let uu____256 = FStar_ST.op_Bang sigelts in sigelt ::
                          uu____256 in
                      FStar_ST.op_Colon_Equals sigelts uu____253);
                     fv) in
              let binders_of_list1 =
                FStar_List.map
                  (fun uu____414  ->
                     match uu____414 with
                     | (t,b) ->
                         let uu____425 = FStar_Syntax_Syntax.as_implicit b in
                         (t, uu____425)) in
              let mk_all_implicit =
                FStar_List.map
                  (fun t  ->
                     let uu____456 = FStar_Syntax_Syntax.as_implicit true in
                     ((FStar_Pervasives_Native.fst t), uu____456)) in
              let args_of_binders1 =
                FStar_List.map
                  (fun bv  ->
                     let uu____479 =
                       FStar_Syntax_Syntax.bv_to_name
                         (FStar_Pervasives_Native.fst bv) in
                     FStar_Syntax_Syntax.as_arg uu____479) in
              let uu____480 =
                let uu____495 =
                  let mk2 f =
                    let t =
                      FStar_Syntax_Syntax.gen_bv "t"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let body =
                      let uu____517 = f (FStar_Syntax_Syntax.bv_to_name t) in
                      FStar_Syntax_Util.arrow gamma uu____517 in
                    let uu____520 =
                      let uu____521 =
                        let uu____528 = FStar_Syntax_Syntax.mk_binder a1 in
                        let uu____529 =
                          let uu____532 = FStar_Syntax_Syntax.mk_binder t in
                          [uu____532] in
                        uu____528 :: uu____529 in
                      FStar_List.append binders uu____521 in
                    FStar_Syntax_Util.abs uu____520 body
                      FStar_Pervasives_Native.None in
                  let uu____537 = mk2 FStar_Syntax_Syntax.mk_Total in
                  let uu____538 = mk2 FStar_Syntax_Syntax.mk_GTotal in
                  (uu____537, uu____538) in
                match uu____495 with
                | (ctx_def,gctx_def) ->
                    let ctx_lid = mk_lid "ctx" in
                    let ctx_fv = register env ctx_lid ctx_def in
                    let gctx_lid = mk_lid "gctx" in
                    let gctx_fv = register env gctx_lid gctx_def in
                    let mk_app1 fv t =
                      let uu____572 =
                        let uu____573 =
                          let uu____588 =
                            let uu____595 =
                              FStar_List.map
                                (fun uu____615  ->
                                   match uu____615 with
                                   | (bv,uu____625) ->
                                       let uu____626 =
                                         FStar_Syntax_Syntax.bv_to_name bv in
                                       let uu____627 =
                                         FStar_Syntax_Syntax.as_implicit
                                           false in
                                       (uu____626, uu____627)) binders in
                            let uu____628 =
                              let uu____635 =
                                let uu____640 =
                                  FStar_Syntax_Syntax.bv_to_name a1 in
                                let uu____641 =
                                  FStar_Syntax_Syntax.as_implicit false in
                                (uu____640, uu____641) in
                              let uu____642 =
                                let uu____649 =
                                  let uu____654 =
                                    FStar_Syntax_Syntax.as_implicit false in
                                  (t, uu____654) in
                                [uu____649] in
                              uu____635 :: uu____642 in
                            FStar_List.append uu____595 uu____628 in
                          (fv, uu____588) in
                        FStar_Syntax_Syntax.Tm_app uu____573 in
                      mk1 uu____572 in
                    (env, (mk_app1 ctx_fv), (mk_app1 gctx_fv)) in
              match uu____480 with
              | (env1,mk_ctx,mk_gctx) ->
                  let c_pure =
                    let t =
                      FStar_Syntax_Syntax.gen_bv "t"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let x =
                      let uu____713 = FStar_Syntax_Syntax.bv_to_name t in
                      FStar_Syntax_Syntax.gen_bv "x"
                        FStar_Pervasives_Native.None uu____713 in
                    let ret1 =
                      let uu____717 =
                        let uu____718 =
                          let uu____721 = FStar_Syntax_Syntax.bv_to_name t in
                          mk_ctx uu____721 in
                        FStar_Syntax_Util.residual_tot uu____718 in
                      FStar_Pervasives_Native.Some uu____717 in
                    let body =
                      let uu____723 = FStar_Syntax_Syntax.bv_to_name x in
                      FStar_Syntax_Util.abs gamma uu____723 ret1 in
                    let uu____724 =
                      let uu____725 = mk_all_implicit binders in
                      let uu____732 =
                        binders_of_list1 [(a1, true); (t, true); (x, false)] in
                      FStar_List.append uu____725 uu____732 in
                    FStar_Syntax_Util.abs uu____724 body ret1 in
                  let c_pure1 =
                    let uu____760 = mk_lid "pure" in
                    register env1 uu____760 c_pure in
                  let c_app =
                    let t1 =
                      FStar_Syntax_Syntax.gen_bv "t1"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t2 =
                      FStar_Syntax_Syntax.gen_bv "t2"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let l =
                      let uu____765 =
                        let uu____766 =
                          let uu____767 =
                            let uu____774 =
                              let uu____775 =
                                let uu____776 =
                                  FStar_Syntax_Syntax.bv_to_name t1 in
                                FStar_Syntax_Syntax.new_bv
                                  FStar_Pervasives_Native.None uu____776 in
                              FStar_Syntax_Syntax.mk_binder uu____775 in
                            [uu____774] in
                          let uu____777 =
                            let uu____780 = FStar_Syntax_Syntax.bv_to_name t2 in
                            FStar_Syntax_Syntax.mk_GTotal uu____780 in
                          FStar_Syntax_Util.arrow uu____767 uu____777 in
                        mk_gctx uu____766 in
                      FStar_Syntax_Syntax.gen_bv "l"
                        FStar_Pervasives_Native.None uu____765 in
                    let r =
                      let uu____782 =
                        let uu____783 = FStar_Syntax_Syntax.bv_to_name t1 in
                        mk_gctx uu____783 in
                      FStar_Syntax_Syntax.gen_bv "r"
                        FStar_Pervasives_Native.None uu____782 in
                    let ret1 =
                      let uu____787 =
                        let uu____788 =
                          let uu____791 = FStar_Syntax_Syntax.bv_to_name t2 in
                          mk_gctx uu____791 in
                        FStar_Syntax_Util.residual_tot uu____788 in
                      FStar_Pervasives_Native.Some uu____787 in
                    let outer_body =
                      let gamma_as_args = args_of_binders1 gamma in
                      let inner_body =
                        let uu____799 = FStar_Syntax_Syntax.bv_to_name l in
                        let uu____802 =
                          let uu____811 =
                            let uu____814 =
                              let uu____815 =
                                let uu____816 =
                                  FStar_Syntax_Syntax.bv_to_name r in
                                FStar_Syntax_Util.mk_app uu____816
                                  gamma_as_args in
                              FStar_Syntax_Syntax.as_arg uu____815 in
                            [uu____814] in
                          FStar_List.append gamma_as_args uu____811 in
                        FStar_Syntax_Util.mk_app uu____799 uu____802 in
                      FStar_Syntax_Util.abs gamma inner_body ret1 in
                    let uu____819 =
                      let uu____820 = mk_all_implicit binders in
                      let uu____827 =
                        binders_of_list1
                          [(a1, true);
                          (t1, true);
                          (t2, true);
                          (l, false);
                          (r, false)] in
                      FStar_List.append uu____820 uu____827 in
                    FStar_Syntax_Util.abs uu____819 outer_body ret1 in
                  let c_app1 =
                    let uu____863 = mk_lid "app" in
                    register env1 uu____863 c_app in
                  let c_lift1 =
                    let t1 =
                      FStar_Syntax_Syntax.gen_bv "t1"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t2 =
                      FStar_Syntax_Syntax.gen_bv "t2"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t_f =
                      let uu____870 =
                        let uu____877 =
                          let uu____878 = FStar_Syntax_Syntax.bv_to_name t1 in
                          FStar_Syntax_Syntax.null_binder uu____878 in
                        [uu____877] in
                      let uu____879 =
                        let uu____882 = FStar_Syntax_Syntax.bv_to_name t2 in
                        FStar_Syntax_Syntax.mk_GTotal uu____882 in
                      FStar_Syntax_Util.arrow uu____870 uu____879 in
                    let f =
                      FStar_Syntax_Syntax.gen_bv "f"
                        FStar_Pervasives_Native.None t_f in
                    let a11 =
                      let uu____885 =
                        let uu____886 = FStar_Syntax_Syntax.bv_to_name t1 in
                        mk_gctx uu____886 in
                      FStar_Syntax_Syntax.gen_bv "a1"
                        FStar_Pervasives_Native.None uu____885 in
                    let ret1 =
                      let uu____890 =
                        let uu____891 =
                          let uu____894 = FStar_Syntax_Syntax.bv_to_name t2 in
                          mk_gctx uu____894 in
                        FStar_Syntax_Util.residual_tot uu____891 in
                      FStar_Pervasives_Native.Some uu____890 in
                    let uu____895 =
                      let uu____896 = mk_all_implicit binders in
                      let uu____903 =
                        binders_of_list1
                          [(a1, true);
                          (t1, true);
                          (t2, true);
                          (f, false);
                          (a11, false)] in
                      FStar_List.append uu____896 uu____903 in
                    let uu____938 =
                      let uu____939 =
                        let uu____948 =
                          let uu____951 =
                            let uu____954 =
                              let uu____963 =
                                let uu____966 =
                                  FStar_Syntax_Syntax.bv_to_name f in
                                [uu____966] in
                              FStar_List.map FStar_Syntax_Syntax.as_arg
                                uu____963 in
                            FStar_Syntax_Util.mk_app c_pure1 uu____954 in
                          let uu____967 =
                            let uu____972 =
                              FStar_Syntax_Syntax.bv_to_name a11 in
                            [uu____972] in
                          uu____951 :: uu____967 in
                        FStar_List.map FStar_Syntax_Syntax.as_arg uu____948 in
                      FStar_Syntax_Util.mk_app c_app1 uu____939 in
                    FStar_Syntax_Util.abs uu____895 uu____938 ret1 in
                  let c_lift11 =
                    let uu____976 = mk_lid "lift1" in
                    register env1 uu____976 c_lift1 in
                  let c_lift2 =
                    let t1 =
                      FStar_Syntax_Syntax.gen_bv "t1"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t2 =
                      FStar_Syntax_Syntax.gen_bv "t2"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t3 =
                      FStar_Syntax_Syntax.gen_bv "t3"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t_f =
                      let uu____984 =
                        let uu____991 =
                          let uu____992 = FStar_Syntax_Syntax.bv_to_name t1 in
                          FStar_Syntax_Syntax.null_binder uu____992 in
                        let uu____993 =
                          let uu____996 =
                            let uu____997 = FStar_Syntax_Syntax.bv_to_name t2 in
                            FStar_Syntax_Syntax.null_binder uu____997 in
                          [uu____996] in
                        uu____991 :: uu____993 in
                      let uu____998 =
                        let uu____1001 = FStar_Syntax_Syntax.bv_to_name t3 in
                        FStar_Syntax_Syntax.mk_GTotal uu____1001 in
                      FStar_Syntax_Util.arrow uu____984 uu____998 in
                    let f =
                      FStar_Syntax_Syntax.gen_bv "f"
                        FStar_Pervasives_Native.None t_f in
                    let a11 =
                      let uu____1004 =
                        let uu____1005 = FStar_Syntax_Syntax.bv_to_name t1 in
                        mk_gctx uu____1005 in
                      FStar_Syntax_Syntax.gen_bv "a1"
                        FStar_Pervasives_Native.None uu____1004 in
                    let a2 =
                      let uu____1007 =
                        let uu____1008 = FStar_Syntax_Syntax.bv_to_name t2 in
                        mk_gctx uu____1008 in
                      FStar_Syntax_Syntax.gen_bv "a2"
                        FStar_Pervasives_Native.None uu____1007 in
                    let ret1 =
                      let uu____1012 =
                        let uu____1013 =
                          let uu____1016 = FStar_Syntax_Syntax.bv_to_name t3 in
                          mk_gctx uu____1016 in
                        FStar_Syntax_Util.residual_tot uu____1013 in
                      FStar_Pervasives_Native.Some uu____1012 in
                    let uu____1017 =
                      let uu____1018 = mk_all_implicit binders in
                      let uu____1025 =
                        binders_of_list1
                          [(a1, true);
                          (t1, true);
                          (t2, true);
                          (t3, true);
                          (f, false);
                          (a11, false);
                          (a2, false)] in
                      FStar_List.append uu____1018 uu____1025 in
                    let uu____1068 =
                      let uu____1069 =
                        let uu____1078 =
                          let uu____1081 =
                            let uu____1084 =
                              let uu____1093 =
                                let uu____1096 =
                                  let uu____1099 =
                                    let uu____1108 =
                                      let uu____1111 =
                                        FStar_Syntax_Syntax.bv_to_name f in
                                      [uu____1111] in
                                    FStar_List.map FStar_Syntax_Syntax.as_arg
                                      uu____1108 in
                                  FStar_Syntax_Util.mk_app c_pure1 uu____1099 in
                                let uu____1112 =
                                  let uu____1117 =
                                    FStar_Syntax_Syntax.bv_to_name a11 in
                                  [uu____1117] in
                                uu____1096 :: uu____1112 in
                              FStar_List.map FStar_Syntax_Syntax.as_arg
                                uu____1093 in
                            FStar_Syntax_Util.mk_app c_app1 uu____1084 in
                          let uu____1120 =
                            let uu____1125 =
                              FStar_Syntax_Syntax.bv_to_name a2 in
                            [uu____1125] in
                          uu____1081 :: uu____1120 in
                        FStar_List.map FStar_Syntax_Syntax.as_arg uu____1078 in
                      FStar_Syntax_Util.mk_app c_app1 uu____1069 in
                    FStar_Syntax_Util.abs uu____1017 uu____1068 ret1 in
                  let c_lift21 =
                    let uu____1129 = mk_lid "lift2" in
                    register env1 uu____1129 c_lift2 in
                  let c_push =
                    let t1 =
                      FStar_Syntax_Syntax.gen_bv "t1"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t2 =
                      FStar_Syntax_Syntax.gen_bv "t2"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t_f =
                      let uu____1136 =
                        let uu____1143 =
                          let uu____1144 = FStar_Syntax_Syntax.bv_to_name t1 in
                          FStar_Syntax_Syntax.null_binder uu____1144 in
                        [uu____1143] in
                      let uu____1145 =
                        let uu____1148 =
                          let uu____1149 = FStar_Syntax_Syntax.bv_to_name t2 in
                          mk_gctx uu____1149 in
                        FStar_Syntax_Syntax.mk_Total uu____1148 in
                      FStar_Syntax_Util.arrow uu____1136 uu____1145 in
                    let f =
                      FStar_Syntax_Syntax.gen_bv "f"
                        FStar_Pervasives_Native.None t_f in
                    let ret1 =
                      let uu____1154 =
                        let uu____1155 =
                          let uu____1158 =
                            let uu____1159 =
                              let uu____1166 =
                                let uu____1167 =
                                  FStar_Syntax_Syntax.bv_to_name t1 in
                                FStar_Syntax_Syntax.null_binder uu____1167 in
                              [uu____1166] in
                            let uu____1168 =
                              let uu____1171 =
                                FStar_Syntax_Syntax.bv_to_name t2 in
                              FStar_Syntax_Syntax.mk_GTotal uu____1171 in
                            FStar_Syntax_Util.arrow uu____1159 uu____1168 in
                          mk_ctx uu____1158 in
                        FStar_Syntax_Util.residual_tot uu____1155 in
                      FStar_Pervasives_Native.Some uu____1154 in
                    let e1 =
                      let uu____1173 = FStar_Syntax_Syntax.bv_to_name t1 in
                      FStar_Syntax_Syntax.gen_bv "e1"
                        FStar_Pervasives_Native.None uu____1173 in
                    let body =
                      let uu____1175 =
                        let uu____1176 =
                          let uu____1183 = FStar_Syntax_Syntax.mk_binder e1 in
                          [uu____1183] in
                        FStar_List.append gamma uu____1176 in
                      let uu____1188 =
                        let uu____1189 = FStar_Syntax_Syntax.bv_to_name f in
                        let uu____1192 =
                          let uu____1201 =
                            let uu____1202 =
                              FStar_Syntax_Syntax.bv_to_name e1 in
                            FStar_Syntax_Syntax.as_arg uu____1202 in
                          let uu____1203 = args_of_binders1 gamma in
                          uu____1201 :: uu____1203 in
                        FStar_Syntax_Util.mk_app uu____1189 uu____1192 in
                      FStar_Syntax_Util.abs uu____1175 uu____1188 ret1 in
                    let uu____1206 =
                      let uu____1207 = mk_all_implicit binders in
                      let uu____1214 =
                        binders_of_list1
                          [(a1, true); (t1, true); (t2, true); (f, false)] in
                      FStar_List.append uu____1207 uu____1214 in
                    FStar_Syntax_Util.abs uu____1206 body ret1 in
                  let c_push1 =
                    let uu____1246 = mk_lid "push" in
                    register env1 uu____1246 c_push in
                  let ret_tot_wp_a =
                    FStar_Pervasives_Native.Some
                      (FStar_Syntax_Util.residual_tot wp_a1) in
                  let mk_generic_app c =
                    if (FStar_List.length binders) > (Prims.parse_int "0")
                    then
                      let uu____1266 =
                        let uu____1267 =
                          let uu____1282 = args_of_binders1 binders in
                          (c, uu____1282) in
                        FStar_Syntax_Syntax.Tm_app uu____1267 in
                      mk1 uu____1266
                    else c in
                  let wp_if_then_else =
                    let result_comp =
                      let uu____1292 =
                        let uu____1293 =
                          let uu____1300 =
                            FStar_Syntax_Syntax.null_binder wp_a1 in
                          let uu____1301 =
                            let uu____1304 =
                              FStar_Syntax_Syntax.null_binder wp_a1 in
                            [uu____1304] in
                          uu____1300 :: uu____1301 in
                        let uu____1305 = FStar_Syntax_Syntax.mk_Total wp_a1 in
                        FStar_Syntax_Util.arrow uu____1293 uu____1305 in
                      FStar_Syntax_Syntax.mk_Total uu____1292 in
                    let c =
                      FStar_Syntax_Syntax.gen_bv "c"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let uu____1309 =
                      let uu____1310 =
                        FStar_Syntax_Syntax.binders_of_list [a1; c] in
                      FStar_List.append binders uu____1310 in
                    let uu____1321 =
                      let l_ite =
                        FStar_Syntax_Syntax.fvar FStar_Parser_Const.ite_lid
                          (FStar_Syntax_Syntax.Delta_defined_at_level
                             (Prims.parse_int "2"))
                          FStar_Pervasives_Native.None in
                      let uu____1323 =
                        let uu____1326 =
                          let uu____1335 =
                            let uu____1338 =
                              let uu____1341 =
                                let uu____1350 =
                                  let uu____1351 =
                                    FStar_Syntax_Syntax.bv_to_name c in
                                  FStar_Syntax_Syntax.as_arg uu____1351 in
                                [uu____1350] in
                              FStar_Syntax_Util.mk_app l_ite uu____1341 in
                            [uu____1338] in
                          FStar_List.map FStar_Syntax_Syntax.as_arg
                            uu____1335 in
                        FStar_Syntax_Util.mk_app c_lift21 uu____1326 in
                      FStar_Syntax_Util.ascribe uu____1323
                        ((FStar_Util.Inr result_comp),
                          FStar_Pervasives_Native.None) in
                    FStar_Syntax_Util.abs uu____1309 uu____1321
                      (FStar_Pervasives_Native.Some
                         (FStar_Syntax_Util.residual_comp_of_comp result_comp)) in
                  let wp_if_then_else1 =
                    let uu____1371 = mk_lid "wp_if_then_else" in
                    register env1 uu____1371 wp_if_then_else in
                  let wp_if_then_else2 = mk_generic_app wp_if_then_else1 in
                  let wp_assert =
                    let q =
                      FStar_Syntax_Syntax.gen_bv "q"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let wp =
                      FStar_Syntax_Syntax.gen_bv "wp"
                        FStar_Pervasives_Native.None wp_a1 in
                    let l_and =
                      FStar_Syntax_Syntax.fvar FStar_Parser_Const.and_lid
                        (FStar_Syntax_Syntax.Delta_defined_at_level
                           (Prims.parse_int "1"))
                        FStar_Pervasives_Native.None in
                    let body =
                      let uu____1382 =
                        let uu____1391 =
                          let uu____1394 =
                            let uu____1397 =
                              let uu____1406 =
                                let uu____1409 =
                                  let uu____1412 =
                                    let uu____1421 =
                                      let uu____1422 =
                                        FStar_Syntax_Syntax.bv_to_name q in
                                      FStar_Syntax_Syntax.as_arg uu____1422 in
                                    [uu____1421] in
                                  FStar_Syntax_Util.mk_app l_and uu____1412 in
                                [uu____1409] in
                              FStar_List.map FStar_Syntax_Syntax.as_arg
                                uu____1406 in
                            FStar_Syntax_Util.mk_app c_pure1 uu____1397 in
                          let uu____1427 =
                            let uu____1432 =
                              FStar_Syntax_Syntax.bv_to_name wp in
                            [uu____1432] in
                          uu____1394 :: uu____1427 in
                        FStar_List.map FStar_Syntax_Syntax.as_arg uu____1391 in
                      FStar_Syntax_Util.mk_app c_app1 uu____1382 in
                    let uu____1435 =
                      let uu____1436 =
                        FStar_Syntax_Syntax.binders_of_list [a1; q; wp] in
                      FStar_List.append binders uu____1436 in
                    FStar_Syntax_Util.abs uu____1435 body ret_tot_wp_a in
                  let wp_assert1 =
                    let uu____1448 = mk_lid "wp_assert" in
                    register env1 uu____1448 wp_assert in
                  let wp_assert2 = mk_generic_app wp_assert1 in
                  let wp_assume =
                    let q =
                      FStar_Syntax_Syntax.gen_bv "q"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let wp =
                      FStar_Syntax_Syntax.gen_bv "wp"
                        FStar_Pervasives_Native.None wp_a1 in
                    let l_imp =
                      FStar_Syntax_Syntax.fvar FStar_Parser_Const.imp_lid
                        (FStar_Syntax_Syntax.Delta_defined_at_level
                           (Prims.parse_int "1"))
                        FStar_Pervasives_Native.None in
                    let body =
                      let uu____1459 =
                        let uu____1468 =
                          let uu____1471 =
                            let uu____1474 =
                              let uu____1483 =
                                let uu____1486 =
                                  let uu____1489 =
                                    let uu____1498 =
                                      let uu____1499 =
                                        FStar_Syntax_Syntax.bv_to_name q in
                                      FStar_Syntax_Syntax.as_arg uu____1499 in
                                    [uu____1498] in
                                  FStar_Syntax_Util.mk_app l_imp uu____1489 in
                                [uu____1486] in
                              FStar_List.map FStar_Syntax_Syntax.as_arg
                                uu____1483 in
                            FStar_Syntax_Util.mk_app c_pure1 uu____1474 in
                          let uu____1504 =
                            let uu____1509 =
                              FStar_Syntax_Syntax.bv_to_name wp in
                            [uu____1509] in
                          uu____1471 :: uu____1504 in
                        FStar_List.map FStar_Syntax_Syntax.as_arg uu____1468 in
                      FStar_Syntax_Util.mk_app c_app1 uu____1459 in
                    let uu____1512 =
                      let uu____1513 =
                        FStar_Syntax_Syntax.binders_of_list [a1; q; wp] in
                      FStar_List.append binders uu____1513 in
                    FStar_Syntax_Util.abs uu____1512 body ret_tot_wp_a in
                  let wp_assume1 =
                    let uu____1525 = mk_lid "wp_assume" in
                    register env1 uu____1525 wp_assume in
                  let wp_assume2 = mk_generic_app wp_assume1 in
                  let wp_close =
                    let b =
                      FStar_Syntax_Syntax.gen_bv "b"
                        FStar_Pervasives_Native.None FStar_Syntax_Util.ktype in
                    let t_f =
                      let uu____1534 =
                        let uu____1541 =
                          let uu____1542 = FStar_Syntax_Syntax.bv_to_name b in
                          FStar_Syntax_Syntax.null_binder uu____1542 in
                        [uu____1541] in
                      let uu____1543 = FStar_Syntax_Syntax.mk_Total wp_a1 in
                      FStar_Syntax_Util.arrow uu____1534 uu____1543 in
                    let f =
                      FStar_Syntax_Syntax.gen_bv "f"
                        FStar_Pervasives_Native.None t_f in
                    let body =
                      let uu____1550 =
                        let uu____1559 =
                          let uu____1562 =
                            let uu____1565 =
                              FStar_List.map FStar_Syntax_Syntax.as_arg
                                [FStar_Syntax_Util.tforall] in
                            FStar_Syntax_Util.mk_app c_pure1 uu____1565 in
                          let uu____1574 =
                            let uu____1579 =
                              let uu____1582 =
                                let uu____1591 =
                                  let uu____1594 =
                                    FStar_Syntax_Syntax.bv_to_name f in
                                  [uu____1594] in
                                FStar_List.map FStar_Syntax_Syntax.as_arg
                                  uu____1591 in
                              FStar_Syntax_Util.mk_app c_push1 uu____1582 in
                            [uu____1579] in
                          uu____1562 :: uu____1574 in
                        FStar_List.map FStar_Syntax_Syntax.as_arg uu____1559 in
                      FStar_Syntax_Util.mk_app c_app1 uu____1550 in
                    let uu____1601 =
                      let uu____1602 =
                        FStar_Syntax_Syntax.binders_of_list [a1; b; f] in
                      FStar_List.append binders uu____1602 in
                    FStar_Syntax_Util.abs uu____1601 body ret_tot_wp_a in
                  let wp_close1 =
                    let uu____1614 = mk_lid "wp_close" in
                    register env1 uu____1614 wp_close in
                  let wp_close2 = mk_generic_app wp_close1 in
                  let ret_tot_type =
                    FStar_Pervasives_Native.Some
                      (FStar_Syntax_Util.residual_tot FStar_Syntax_Util.ktype) in
                  let ret_gtot_type =
                    let uu____1624 =
                      let uu____1625 =
                        let uu____1626 =
                          FStar_Syntax_Syntax.mk_GTotal
                            FStar_Syntax_Util.ktype in
                        FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp
                          uu____1626 in
                      FStar_Syntax_Util.residual_comp_of_lcomp uu____1625 in
                    FStar_Pervasives_Native.Some uu____1624 in
                  let mk_forall1 x body =
                    let uu____1638 =
                      let uu____1641 =
                        let uu____1642 =
                          let uu____1657 =
                            let uu____1660 =
                              let uu____1661 =
                                let uu____1662 =
                                  let uu____1663 =
                                    FStar_Syntax_Syntax.mk_binder x in
                                  [uu____1663] in
                                FStar_Syntax_Util.abs uu____1662 body
                                  ret_tot_type in
                              FStar_Syntax_Syntax.as_arg uu____1661 in
                            [uu____1660] in
                          (FStar_Syntax_Util.tforall, uu____1657) in
                        FStar_Syntax_Syntax.Tm_app uu____1642 in
                      FStar_Syntax_Syntax.mk uu____1641 in
                    uu____1638 FStar_Pervasives_Native.None
                      FStar_Range.dummyRange in
                  let rec is_discrete t =
                    let uu____1673 =
                      let uu____1674 = FStar_Syntax_Subst.compress t in
                      uu____1674.FStar_Syntax_Syntax.n in
                    match uu____1673 with
                    | FStar_Syntax_Syntax.Tm_type uu____1677 -> false
                    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
                        (FStar_List.for_all
                           (fun uu____1703  ->
                              match uu____1703 with
                              | (b,uu____1709) ->
                                  is_discrete b.FStar_Syntax_Syntax.sort) bs)
                          && (is_discrete (FStar_Syntax_Util.comp_result c))
                    | uu____1710 -> true in
                  let rec is_monotonic t =
                    let uu____1715 =
                      let uu____1716 = FStar_Syntax_Subst.compress t in
                      uu____1716.FStar_Syntax_Syntax.n in
                    match uu____1715 with
                    | FStar_Syntax_Syntax.Tm_type uu____1719 -> true
                    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
                        (FStar_List.for_all
                           (fun uu____1745  ->
                              match uu____1745 with
                              | (b,uu____1751) ->
                                  is_discrete b.FStar_Syntax_Syntax.sort) bs)
                          && (is_monotonic (FStar_Syntax_Util.comp_result c))
                    | uu____1752 -> is_discrete t in
                  let rec mk_rel rel t x y =
                    let mk_rel1 = mk_rel rel in
                    let t1 =
                      FStar_TypeChecker_Normalize.normalize
                        [FStar_TypeChecker_Normalize.Beta;
                        FStar_TypeChecker_Normalize.Eager_unfolding;
                        FStar_TypeChecker_Normalize.UnfoldUntil
                          FStar_Syntax_Syntax.Delta_constant] env1 t in
                    let uu____1804 =
                      let uu____1805 = FStar_Syntax_Subst.compress t1 in
                      uu____1805.FStar_Syntax_Syntax.n in
                    match uu____1804 with
                    | FStar_Syntax_Syntax.Tm_type uu____1808 -> rel x y
                    | FStar_Syntax_Syntax.Tm_arrow
                        (binder::[],{
                                      FStar_Syntax_Syntax.n =
                                        FStar_Syntax_Syntax.GTotal
                                        (b,uu____1811);
                                      FStar_Syntax_Syntax.pos = uu____1812;
                                      FStar_Syntax_Syntax.vars = uu____1813;_})
                        ->
                        let a2 =
                          (FStar_Pervasives_Native.fst binder).FStar_Syntax_Syntax.sort in
                        let uu____1847 =
                          (is_monotonic a2) || (is_monotonic b) in
                        if uu____1847
                        then
                          let a11 =
                            FStar_Syntax_Syntax.gen_bv "a1"
                              FStar_Pervasives_Native.None a2 in
                          let body =
                            let uu____1850 =
                              let uu____1853 =
                                let uu____1862 =
                                  let uu____1863 =
                                    FStar_Syntax_Syntax.bv_to_name a11 in
                                  FStar_Syntax_Syntax.as_arg uu____1863 in
                                [uu____1862] in
                              FStar_Syntax_Util.mk_app x uu____1853 in
                            let uu____1864 =
                              let uu____1867 =
                                let uu____1876 =
                                  let uu____1877 =
                                    FStar_Syntax_Syntax.bv_to_name a11 in
                                  FStar_Syntax_Syntax.as_arg uu____1877 in
                                [uu____1876] in
                              FStar_Syntax_Util.mk_app y uu____1867 in
                            mk_rel1 b uu____1850 uu____1864 in
                          mk_forall1 a11 body
                        else
                          (let a11 =
                             FStar_Syntax_Syntax.gen_bv "a1"
                               FStar_Pervasives_Native.None a2 in
                           let a21 =
                             FStar_Syntax_Syntax.gen_bv "a2"
                               FStar_Pervasives_Native.None a2 in
                           let body =
                             let uu____1882 =
                               let uu____1883 =
                                 FStar_Syntax_Syntax.bv_to_name a11 in
                               let uu____1886 =
                                 FStar_Syntax_Syntax.bv_to_name a21 in
                               mk_rel1 a2 uu____1883 uu____1886 in
                             let uu____1889 =
                               let uu____1890 =
                                 let uu____1893 =
                                   let uu____1902 =
                                     let uu____1903 =
                                       FStar_Syntax_Syntax.bv_to_name a11 in
                                     FStar_Syntax_Syntax.as_arg uu____1903 in
                                   [uu____1902] in
                                 FStar_Syntax_Util.mk_app x uu____1893 in
                               let uu____1904 =
                                 let uu____1907 =
                                   let uu____1916 =
                                     let uu____1917 =
                                       FStar_Syntax_Syntax.bv_to_name a21 in
                                     FStar_Syntax_Syntax.as_arg uu____1917 in
                                   [uu____1916] in
                                 FStar_Syntax_Util.mk_app y uu____1907 in
                               mk_rel1 b uu____1890 uu____1904 in
                             FStar_Syntax_Util.mk_imp uu____1882 uu____1889 in
                           let uu____1918 = mk_forall1 a21 body in
                           mk_forall1 a11 uu____1918)
                    | FStar_Syntax_Syntax.Tm_arrow
                        (binder::[],{
                                      FStar_Syntax_Syntax.n =
                                        FStar_Syntax_Syntax.Total
                                        (b,uu____1921);
                                      FStar_Syntax_Syntax.pos = uu____1922;
                                      FStar_Syntax_Syntax.vars = uu____1923;_})
                        ->
                        let a2 =
                          (FStar_Pervasives_Native.fst binder).FStar_Syntax_Syntax.sort in
                        let uu____1957 =
                          (is_monotonic a2) || (is_monotonic b) in
                        if uu____1957
                        then
                          let a11 =
                            FStar_Syntax_Syntax.gen_bv "a1"
                              FStar_Pervasives_Native.None a2 in
                          let body =
                            let uu____1960 =
                              let uu____1963 =
                                let uu____1972 =
                                  let uu____1973 =
                                    FStar_Syntax_Syntax.bv_to_name a11 in
                                  FStar_Syntax_Syntax.as_arg uu____1973 in
                                [uu____1972] in
                              FStar_Syntax_Util.mk_app x uu____1963 in
                            let uu____1974 =
                              let uu____1977 =
                                let uu____1986 =
                                  let uu____1987 =
                                    FStar_Syntax_Syntax.bv_to_name a11 in
                                  FStar_Syntax_Syntax.as_arg uu____1987 in
                                [uu____1986] in
                              FStar_Syntax_Util.mk_app y uu____1977 in
                            mk_rel1 b uu____1960 uu____1974 in
                          mk_forall1 a11 body
                        else
                          (let a11 =
                             FStar_Syntax_Syntax.gen_bv "a1"
                               FStar_Pervasives_Native.None a2 in
                           let a21 =
                             FStar_Syntax_Syntax.gen_bv "a2"
                               FStar_Pervasives_Native.None a2 in
                           let body =
                             let uu____1992 =
                               let uu____1993 =
                                 FStar_Syntax_Syntax.bv_to_name a11 in
                               let uu____1996 =
                                 FStar_Syntax_Syntax.bv_to_name a21 in
                               mk_rel1 a2 uu____1993 uu____1996 in
                             let uu____1999 =
                               let uu____2000 =
                                 let uu____2003 =
                                   let uu____2012 =
                                     let uu____2013 =
                                       FStar_Syntax_Syntax.bv_to_name a11 in
                                     FStar_Syntax_Syntax.as_arg uu____2013 in
                                   [uu____2012] in
                                 FStar_Syntax_Util.mk_app x uu____2003 in
                               let uu____2014 =
                                 let uu____2017 =
                                   let uu____2026 =
                                     let uu____2027 =
                                       FStar_Syntax_Syntax.bv_to_name a21 in
                                     FStar_Syntax_Syntax.as_arg uu____2027 in
                                   [uu____2026] in
                                 FStar_Syntax_Util.mk_app y uu____2017 in
                               mk_rel1 b uu____2000 uu____2014 in
                             FStar_Syntax_Util.mk_imp uu____1992 uu____1999 in
                           let uu____2028 = mk_forall1 a21 body in
                           mk_forall1 a11 uu____2028)
                    | FStar_Syntax_Syntax.Tm_arrow (binder::binders1,comp) ->
                        let t2 =
                          let uu___291_2059 = t1 in
                          let uu____2060 =
                            let uu____2061 =
                              let uu____2074 =
                                let uu____2075 =
                                  FStar_Syntax_Util.arrow binders1 comp in
                                FStar_Syntax_Syntax.mk_Total uu____2075 in
                              ([binder], uu____2074) in
                            FStar_Syntax_Syntax.Tm_arrow uu____2061 in
                          {
                            FStar_Syntax_Syntax.n = uu____2060;
                            FStar_Syntax_Syntax.pos =
                              (uu___291_2059.FStar_Syntax_Syntax.pos);
                            FStar_Syntax_Syntax.vars =
                              (uu___291_2059.FStar_Syntax_Syntax.vars)
                          } in
                        mk_rel1 t2 x y
                    | FStar_Syntax_Syntax.Tm_arrow uu____2090 ->
                        failwith "unhandled arrow"
                    | uu____2103 -> FStar_Syntax_Util.mk_untyped_eq2 x y in
                  let stronger =
                    let wp1 =
                      FStar_Syntax_Syntax.gen_bv "wp1"
                        FStar_Pervasives_Native.None wp_a1 in
                    let wp2 =
                      FStar_Syntax_Syntax.gen_bv "wp2"
                        FStar_Pervasives_Native.None wp_a1 in
                    let rec mk_stronger t x y =
                      let t1 =
                        FStar_TypeChecker_Normalize.normalize
                          [FStar_TypeChecker_Normalize.Beta;
                          FStar_TypeChecker_Normalize.Eager_unfolding;
                          FStar_TypeChecker_Normalize.UnfoldUntil
                            FStar_Syntax_Syntax.Delta_constant] env1 t in
                      let uu____2118 =
                        let uu____2119 = FStar_Syntax_Subst.compress t1 in
                        uu____2119.FStar_Syntax_Syntax.n in
                      match uu____2118 with
                      | FStar_Syntax_Syntax.Tm_type uu____2122 ->
                          FStar_Syntax_Util.mk_imp x y
                      | FStar_Syntax_Syntax.Tm_app (head1,args) when
                          let uu____2145 = FStar_Syntax_Subst.compress head1 in
                          FStar_Syntax_Util.is_tuple_constructor uu____2145
                          ->
                          let project i tuple =
                            let projector =
                              let uu____2160 =
                                let uu____2161 =
                                  FStar_Parser_Const.mk_tuple_data_lid
                                    (FStar_List.length args)
                                    FStar_Range.dummyRange in
                                FStar_TypeChecker_Env.lookup_projector env1
                                  uu____2161 i in
                              FStar_Syntax_Syntax.fvar uu____2160
                                (FStar_Syntax_Syntax.Delta_defined_at_level
                                   (Prims.parse_int "1"))
                                FStar_Pervasives_Native.None in
                            FStar_Syntax_Util.mk_app projector
                              [(tuple, FStar_Pervasives_Native.None)] in
                          let uu____2188 =
                            let uu____2195 =
                              FStar_List.mapi
                                (fun i  ->
                                   fun uu____2209  ->
                                     match uu____2209 with
                                     | (t2,q) ->
                                         let uu____2216 = project i x in
                                         let uu____2217 = project i y in
                                         mk_stronger t2 uu____2216 uu____2217)
                                args in
                            match uu____2195 with
                            | [] ->
                                failwith
                                  "Impossible : Empty application when creating stronger relation in DM4F"
                            | rel0::rels -> (rel0, rels) in
                          (match uu____2188 with
                           | (rel0,rels) ->
                               FStar_List.fold_left FStar_Syntax_Util.mk_conj
                                 rel0 rels)
                      | FStar_Syntax_Syntax.Tm_arrow
                          (binders1,{
                                      FStar_Syntax_Syntax.n =
                                        FStar_Syntax_Syntax.GTotal
                                        (b,uu____2244);
                                      FStar_Syntax_Syntax.pos = uu____2245;
                                      FStar_Syntax_Syntax.vars = uu____2246;_})
                          ->
                          let bvs =
                            FStar_List.mapi
                              (fun i  ->
                                 fun uu____2284  ->
                                   match uu____2284 with
                                   | (bv,q) ->
                                       let uu____2291 =
                                         let uu____2292 =
                                           FStar_Util.string_of_int i in
                                         Prims.strcat "a" uu____2292 in
                                       FStar_Syntax_Syntax.gen_bv uu____2291
                                         FStar_Pervasives_Native.None
                                         bv.FStar_Syntax_Syntax.sort)
                              binders1 in
                          let args =
                            FStar_List.map
                              (fun ai  ->
                                 let uu____2299 =
                                   FStar_Syntax_Syntax.bv_to_name ai in
                                 FStar_Syntax_Syntax.as_arg uu____2299) bvs in
                          let body =
                            let uu____2301 = FStar_Syntax_Util.mk_app x args in
                            let uu____2302 = FStar_Syntax_Util.mk_app y args in
                            mk_stronger b uu____2301 uu____2302 in
                          FStar_List.fold_right
                            (fun bv  -> fun body1  -> mk_forall1 bv body1)
                            bvs body
                      | FStar_Syntax_Syntax.Tm_arrow
                          (binders1,{
                                      FStar_Syntax_Syntax.n =
                                        FStar_Syntax_Syntax.Total
                                        (b,uu____2309);
                                      FStar_Syntax_Syntax.pos = uu____2310;
                                      FStar_Syntax_Syntax.vars = uu____2311;_})
                          ->
                          let bvs =
                            FStar_List.mapi
                              (fun i  ->
                                 fun uu____2349  ->
                                   match uu____2349 with
                                   | (bv,q) ->
                                       let uu____2356 =
                                         let uu____2357 =
                                           FStar_Util.string_of_int i in
                                         Prims.strcat "a" uu____2357 in
                                       FStar_Syntax_Syntax.gen_bv uu____2356
                                         FStar_Pervasives_Native.None
                                         bv.FStar_Syntax_Syntax.sort)
                              binders1 in
                          let args =
                            FStar_List.map
                              (fun ai  ->
                                 let uu____2364 =
                                   FStar_Syntax_Syntax.bv_to_name ai in
                                 FStar_Syntax_Syntax.as_arg uu____2364) bvs in
                          let body =
                            let uu____2366 = FStar_Syntax_Util.mk_app x args in
                            let uu____2367 = FStar_Syntax_Util.mk_app y args in
                            mk_stronger b uu____2366 uu____2367 in
                          FStar_List.fold_right
                            (fun bv  -> fun body1  -> mk_forall1 bv body1)
                            bvs body
                      | uu____2372 -> failwith "Not a DM elaborated type" in
                    let body =
                      let uu____2374 = FStar_Syntax_Util.unascribe wp_a1 in
                      let uu____2375 = FStar_Syntax_Syntax.bv_to_name wp1 in
                      let uu____2376 = FStar_Syntax_Syntax.bv_to_name wp2 in
                      mk_stronger uu____2374 uu____2375 uu____2376 in
                    let uu____2377 =
                      let uu____2378 =
                        binders_of_list1
                          [(a1, false); (wp1, false); (wp2, false)] in
                      FStar_List.append binders uu____2378 in
                    FStar_Syntax_Util.abs uu____2377 body ret_tot_type in
                  let stronger1 =
                    let uu____2406 = mk_lid "stronger" in
                    register env1 uu____2406 stronger in
                  let stronger2 = mk_generic_app stronger1 in
                  let wp_ite =
                    let wp =
                      FStar_Syntax_Syntax.gen_bv "wp"
                        FStar_Pervasives_Native.None wp_a1 in
                    let uu____2412 = FStar_Util.prefix gamma in
                    match uu____2412 with
                    | (wp_args,post) ->
                        let k =
                          FStar_Syntax_Syntax.gen_bv "k"
                            FStar_Pervasives_Native.None
                            (FStar_Pervasives_Native.fst post).FStar_Syntax_Syntax.sort in
                        let equiv1 =
                          let k_tm = FStar_Syntax_Syntax.bv_to_name k in
                          let eq1 =
                            let uu____2457 =
                              FStar_Syntax_Syntax.bv_to_name
                                (FStar_Pervasives_Native.fst post) in
                            mk_rel FStar_Syntax_Util.mk_iff
                              k.FStar_Syntax_Syntax.sort k_tm uu____2457 in
                          let uu____2460 =
                            FStar_Syntax_Util.destruct_typ_as_formula eq1 in
                          match uu____2460 with
                          | FStar_Pervasives_Native.Some
                              (FStar_Syntax_Util.QAll (binders1,[],body)) ->
                              let k_app =
                                let uu____2470 = args_of_binders1 binders1 in
                                FStar_Syntax_Util.mk_app k_tm uu____2470 in
                              let guard_free1 =
                                let uu____2480 =
                                  FStar_Syntax_Syntax.lid_as_fv
                                    FStar_Parser_Const.guard_free
                                    FStar_Syntax_Syntax.Delta_constant
                                    FStar_Pervasives_Native.None in
                                FStar_Syntax_Syntax.fv_to_tm uu____2480 in
                              let pat =
                                let uu____2484 =
                                  let uu____2493 =
                                    FStar_Syntax_Syntax.as_arg k_app in
                                  [uu____2493] in
                                FStar_Syntax_Util.mk_app guard_free1
                                  uu____2484 in
                              let pattern_guarded_body =
                                let uu____2497 =
                                  let uu____2498 =
                                    let uu____2505 =
                                      let uu____2506 =
                                        let uu____2517 =
                                          let uu____2520 =
                                            FStar_Syntax_Syntax.as_arg pat in
                                          [uu____2520] in
                                        [uu____2517] in
                                      FStar_Syntax_Syntax.Meta_pattern
                                        uu____2506 in
                                    (body, uu____2505) in
                                  FStar_Syntax_Syntax.Tm_meta uu____2498 in
                                mk1 uu____2497 in
                              FStar_Syntax_Util.close_forall_no_univs
                                binders1 pattern_guarded_body
                          | uu____2525 ->
                              failwith
                                "Impossible: Expected the equivalence to be a quantified formula" in
                        let body =
                          let uu____2529 =
                            let uu____2530 =
                              let uu____2531 =
                                let uu____2532 =
                                  FStar_Syntax_Syntax.bv_to_name wp in
                                let uu____2535 =
                                  let uu____2544 = args_of_binders1 wp_args in
                                  let uu____2547 =
                                    let uu____2550 =
                                      let uu____2551 =
                                        FStar_Syntax_Syntax.bv_to_name k in
                                      FStar_Syntax_Syntax.as_arg uu____2551 in
                                    [uu____2550] in
                                  FStar_List.append uu____2544 uu____2547 in
                                FStar_Syntax_Util.mk_app uu____2532
                                  uu____2535 in
                              FStar_Syntax_Util.mk_imp equiv1 uu____2531 in
                            FStar_Syntax_Util.mk_forall_no_univ k uu____2530 in
                          FStar_Syntax_Util.abs gamma uu____2529
                            ret_gtot_type in
                        let uu____2552 =
                          let uu____2553 =
                            FStar_Syntax_Syntax.binders_of_list [a1; wp] in
                          FStar_List.append binders uu____2553 in
                        FStar_Syntax_Util.abs uu____2552 body ret_gtot_type in
                  let wp_ite1 =
                    let uu____2565 = mk_lid "wp_ite" in
                    register env1 uu____2565 wp_ite in
                  let wp_ite2 = mk_generic_app wp_ite1 in
                  let null_wp =
                    let wp =
                      FStar_Syntax_Syntax.gen_bv "wp"
                        FStar_Pervasives_Native.None wp_a1 in
                    let uu____2571 = FStar_Util.prefix gamma in
                    match uu____2571 with
                    | (wp_args,post) ->
                        let x =
                          FStar_Syntax_Syntax.gen_bv "x"
                            FStar_Pervasives_Native.None
                            FStar_Syntax_Syntax.tun in
                        let body =
                          let uu____2614 =
                            let uu____2615 =
                              FStar_All.pipe_left
                                FStar_Syntax_Syntax.bv_to_name
                                (FStar_Pervasives_Native.fst post) in
                            let uu____2618 =
                              let uu____2627 =
                                let uu____2628 =
                                  FStar_Syntax_Syntax.bv_to_name x in
                                FStar_Syntax_Syntax.as_arg uu____2628 in
                              [uu____2627] in
                            FStar_Syntax_Util.mk_app uu____2615 uu____2618 in
                          FStar_Syntax_Util.mk_forall_no_univ x uu____2614 in
                        let uu____2629 =
                          let uu____2630 =
                            let uu____2637 =
                              FStar_Syntax_Syntax.binders_of_list [a1] in
                            FStar_List.append uu____2637 gamma in
                          FStar_List.append binders uu____2630 in
                        FStar_Syntax_Util.abs uu____2629 body ret_gtot_type in
                  let null_wp1 =
                    let uu____2653 = mk_lid "null_wp" in
                    register env1 uu____2653 null_wp in
                  let null_wp2 = mk_generic_app null_wp1 in
                  let wp_trivial =
                    let wp =
                      FStar_Syntax_Syntax.gen_bv "wp"
                        FStar_Pervasives_Native.None wp_a1 in
                    let body =
                      let uu____2662 =
                        let uu____2671 =
                          let uu____2674 = FStar_Syntax_Syntax.bv_to_name a1 in
                          let uu____2675 =
                            let uu____2678 =
                              let uu____2681 =
                                let uu____2690 =
                                  let uu____2691 =
                                    FStar_Syntax_Syntax.bv_to_name a1 in
                                  FStar_Syntax_Syntax.as_arg uu____2691 in
                                [uu____2690] in
                              FStar_Syntax_Util.mk_app null_wp2 uu____2681 in
                            let uu____2692 =
                              let uu____2697 =
                                FStar_Syntax_Syntax.bv_to_name wp in
                              [uu____2697] in
                            uu____2678 :: uu____2692 in
                          uu____2674 :: uu____2675 in
                        FStar_List.map FStar_Syntax_Syntax.as_arg uu____2671 in
                      FStar_Syntax_Util.mk_app stronger2 uu____2662 in
                    let uu____2700 =
                      let uu____2701 =
                        FStar_Syntax_Syntax.binders_of_list [a1; wp] in
                      FStar_List.append binders uu____2701 in
                    FStar_Syntax_Util.abs uu____2700 body ret_tot_type in
                  let wp_trivial1 =
                    let uu____2713 = mk_lid "wp_trivial" in
                    register env1 uu____2713 wp_trivial in
                  let wp_trivial2 = mk_generic_app wp_trivial1 in
                  ((let uu____2718 =
                      FStar_TypeChecker_Env.debug env1
                        (FStar_Options.Other "ED") in
                    if uu____2718
                    then d "End Dijkstra monads for free"
                    else ());
                   (let c = FStar_Syntax_Subst.close binders in
                    let uu____2723 =
                      let uu____2726 = FStar_ST.op_Bang sigelts in
                      FStar_List.rev uu____2726 in
                    let uu____2793 =
                      let uu___292_2794 = ed in
                      let uu____2795 =
                        let uu____2796 = c wp_if_then_else2 in
                        ([], uu____2796) in
                      let uu____2799 =
                        let uu____2800 = c wp_ite2 in ([], uu____2800) in
                      let uu____2803 =
                        let uu____2804 = c stronger2 in ([], uu____2804) in
                      let uu____2807 =
                        let uu____2808 = c wp_close2 in ([], uu____2808) in
                      let uu____2811 =
                        let uu____2812 = c wp_assert2 in ([], uu____2812) in
                      let uu____2815 =
                        let uu____2816 = c wp_assume2 in ([], uu____2816) in
                      let uu____2819 =
                        let uu____2820 = c null_wp2 in ([], uu____2820) in
                      let uu____2823 =
                        let uu____2824 = c wp_trivial2 in ([], uu____2824) in
                      {
                        FStar_Syntax_Syntax.cattributes =
                          (uu___292_2794.FStar_Syntax_Syntax.cattributes);
                        FStar_Syntax_Syntax.mname =
                          (uu___292_2794.FStar_Syntax_Syntax.mname);
                        FStar_Syntax_Syntax.univs =
                          (uu___292_2794.FStar_Syntax_Syntax.univs);
                        FStar_Syntax_Syntax.binders =
                          (uu___292_2794.FStar_Syntax_Syntax.binders);
                        FStar_Syntax_Syntax.signature =
                          (uu___292_2794.FStar_Syntax_Syntax.signature);
                        FStar_Syntax_Syntax.ret_wp =
                          (uu___292_2794.FStar_Syntax_Syntax.ret_wp);
                        FStar_Syntax_Syntax.bind_wp =
                          (uu___292_2794.FStar_Syntax_Syntax.bind_wp);
                        FStar_Syntax_Syntax.if_then_else = uu____2795;
                        FStar_Syntax_Syntax.ite_wp = uu____2799;
                        FStar_Syntax_Syntax.stronger = uu____2803;
                        FStar_Syntax_Syntax.close_wp = uu____2807;
                        FStar_Syntax_Syntax.assert_p = uu____2811;
                        FStar_Syntax_Syntax.assume_p = uu____2815;
                        FStar_Syntax_Syntax.null_wp = uu____2819;
                        FStar_Syntax_Syntax.trivial = uu____2823;
                        FStar_Syntax_Syntax.repr =
                          (uu___292_2794.FStar_Syntax_Syntax.repr);
                        FStar_Syntax_Syntax.return_repr =
                          (uu___292_2794.FStar_Syntax_Syntax.return_repr);
                        FStar_Syntax_Syntax.bind_repr =
                          (uu___292_2794.FStar_Syntax_Syntax.bind_repr);
                        FStar_Syntax_Syntax.actions =
                          (uu___292_2794.FStar_Syntax_Syntax.actions)
                      } in
                    (uu____2723, uu____2793)))))
type env_ = env[@@deriving show]
let get_env: env -> FStar_TypeChecker_Env.env = fun env  -> env.env
let set_env: env -> FStar_TypeChecker_Env.env -> env =
  fun dmff_env  ->
    fun env'  ->
      let uu___293_2838 = dmff_env in
      {
        env = env';
        subst = (uu___293_2838.subst);
        tc_const = (uu___293_2838.tc_const)
      }
type nm =
  | N of FStar_Syntax_Syntax.typ
  | M of FStar_Syntax_Syntax.typ[@@deriving show]
let uu___is_N: nm -> Prims.bool =
  fun projectee  -> match projectee with | N _0 -> true | uu____2851 -> false
let __proj__N__item___0: nm -> FStar_Syntax_Syntax.typ =
  fun projectee  -> match projectee with | N _0 -> _0
let uu___is_M: nm -> Prims.bool =
  fun projectee  -> match projectee with | M _0 -> true | uu____2863 -> false
let __proj__M__item___0: nm -> FStar_Syntax_Syntax.typ =
  fun projectee  -> match projectee with | M _0 -> _0
type nm_ = nm[@@deriving show]
let nm_of_comp: FStar_Syntax_Syntax.comp' -> nm =
  fun uu___279_2873  ->
    match uu___279_2873 with
    | FStar_Syntax_Syntax.Total (t,uu____2875) -> N t
    | FStar_Syntax_Syntax.Comp c when
        FStar_All.pipe_right c.FStar_Syntax_Syntax.flags
          (FStar_Util.for_some
             (fun uu___278_2888  ->
                match uu___278_2888 with
                | FStar_Syntax_Syntax.CPS  -> true
                | uu____2889 -> false))
        -> M (c.FStar_Syntax_Syntax.result_typ)
    | FStar_Syntax_Syntax.Comp c ->
        let uu____2891 =
          let uu____2892 =
            let uu____2893 = FStar_Syntax_Syntax.mk_Comp c in
            FStar_All.pipe_left FStar_Syntax_Print.comp_to_string uu____2893 in
          FStar_Util.format1 "[nm_of_comp]: impossible (%s)" uu____2892 in
        failwith uu____2891
    | FStar_Syntax_Syntax.GTotal uu____2894 ->
        failwith "[nm_of_comp]: impossible (GTot)"
let string_of_nm: nm -> Prims.string =
  fun uu___280_2905  ->
    match uu___280_2905 with
    | N t ->
        let uu____2907 = FStar_Syntax_Print.term_to_string t in
        FStar_Util.format1 "N[%s]" uu____2907
    | M t ->
        let uu____2909 = FStar_Syntax_Print.term_to_string t in
        FStar_Util.format1 "M[%s]" uu____2909
let is_monadic_arrow: FStar_Syntax_Syntax.term' -> nm =
  fun n1  ->
    match n1 with
    | FStar_Syntax_Syntax.Tm_arrow
        (uu____2913,{ FStar_Syntax_Syntax.n = n2;
                      FStar_Syntax_Syntax.pos = uu____2915;
                      FStar_Syntax_Syntax.vars = uu____2916;_})
        -> nm_of_comp n2
    | uu____2933 -> failwith "unexpected_argument: [is_monadic_arrow]"
let is_monadic_comp:
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool =
  fun c  ->
    let uu____2941 = nm_of_comp c.FStar_Syntax_Syntax.n in
    match uu____2941 with | M uu____2942 -> true | N uu____2943 -> false
exception Not_found
let uu___is_Not_found: Prims.exn -> Prims.bool =
  fun projectee  ->
    match projectee with | Not_found  -> true | uu____2947 -> false
let double_star: FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ =
  fun typ  ->
    let star_once typ1 =
      let uu____2957 =
        let uu____2964 =
          let uu____2965 =
            FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None typ1 in
          FStar_All.pipe_left FStar_Syntax_Syntax.mk_binder uu____2965 in
        [uu____2964] in
      let uu____2966 = FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0 in
      FStar_Syntax_Util.arrow uu____2957 uu____2966 in
    let uu____2969 = FStar_All.pipe_right typ star_once in
    FStar_All.pipe_left star_once uu____2969
let rec mk_star_to_type:
  (FStar_Syntax_Syntax.term' ->
     FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
    ->
    env ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
  =
  fun mk1  ->
    fun env  ->
      fun a  ->
        mk1
          (let uu____3006 =
             let uu____3019 =
               let uu____3026 =
                 let uu____3031 =
                   let uu____3032 = star_type' env a in
                   FStar_Syntax_Syntax.null_bv uu____3032 in
                 let uu____3033 = FStar_Syntax_Syntax.as_implicit false in
                 (uu____3031, uu____3033) in
               [uu____3026] in
             let uu____3042 =
               FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0 in
             (uu____3019, uu____3042) in
           FStar_Syntax_Syntax.Tm_arrow uu____3006)
and star_type':
  env ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term
  =
  fun env  ->
    fun t  ->
      let mk1 x =
        FStar_Syntax_Syntax.mk x FStar_Pervasives_Native.None
          t.FStar_Syntax_Syntax.pos in
      let mk_star_to_type1 = mk_star_to_type mk1 in
      let t1 = FStar_Syntax_Subst.compress t in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_arrow (binders,uu____3070) ->
          let binders1 =
            FStar_List.map
              (fun uu____3106  ->
                 match uu____3106 with
                 | (bv,aqual) ->
                     let uu____3117 =
                       let uu___294_3118 = bv in
                       let uu____3119 =
                         star_type' env bv.FStar_Syntax_Syntax.sort in
                       {
                         FStar_Syntax_Syntax.ppname =
                           (uu___294_3118.FStar_Syntax_Syntax.ppname);
                         FStar_Syntax_Syntax.index =
                           (uu___294_3118.FStar_Syntax_Syntax.index);
                         FStar_Syntax_Syntax.sort = uu____3119
                       } in
                     (uu____3117, aqual)) binders in
          (match t1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_arrow
               (uu____3122,{
                             FStar_Syntax_Syntax.n =
                               FStar_Syntax_Syntax.GTotal (hn,uu____3124);
                             FStar_Syntax_Syntax.pos = uu____3125;
                             FStar_Syntax_Syntax.vars = uu____3126;_})
               ->
               let uu____3151 =
                 let uu____3152 =
                   let uu____3165 =
                     let uu____3166 = star_type' env hn in
                     FStar_Syntax_Syntax.mk_GTotal uu____3166 in
                   (binders1, uu____3165) in
                 FStar_Syntax_Syntax.Tm_arrow uu____3152 in
               mk1 uu____3151
           | uu____3173 ->
               let uu____3174 = is_monadic_arrow t1.FStar_Syntax_Syntax.n in
               (match uu____3174 with
                | N hn ->
                    let uu____3176 =
                      let uu____3177 =
                        let uu____3190 =
                          let uu____3191 = star_type' env hn in
                          FStar_Syntax_Syntax.mk_Total uu____3191 in
                        (binders1, uu____3190) in
                      FStar_Syntax_Syntax.Tm_arrow uu____3177 in
                    mk1 uu____3176
                | M a ->
                    let uu____3199 =
                      let uu____3200 =
                        let uu____3213 =
                          let uu____3220 =
                            let uu____3227 =
                              let uu____3232 =
                                let uu____3233 = mk_star_to_type1 env a in
                                FStar_Syntax_Syntax.null_bv uu____3233 in
                              let uu____3234 =
                                FStar_Syntax_Syntax.as_implicit false in
                              (uu____3232, uu____3234) in
                            [uu____3227] in
                          FStar_List.append binders1 uu____3220 in
                        let uu____3247 =
                          FStar_Syntax_Syntax.mk_Total
                            FStar_Syntax_Util.ktype0 in
                        (uu____3213, uu____3247) in
                      FStar_Syntax_Syntax.Tm_arrow uu____3200 in
                    mk1 uu____3199))
      | FStar_Syntax_Syntax.Tm_app (head1,args) ->
          let debug1 t2 s =
            let string_of_set f s1 =
              let elts = FStar_Util.set_elements s1 in
              match elts with
              | [] -> "{}"
              | x::xs ->
                  let strb = FStar_Util.new_string_builder () in
                  (FStar_Util.string_builder_append strb "{";
                   (let uu____3317 = f x in
                    FStar_Util.string_builder_append strb uu____3317);
                   FStar_List.iter
                     (fun x1  ->
                        FStar_Util.string_builder_append strb ", ";
                        (let uu____3324 = f x1 in
                         FStar_Util.string_builder_append strb uu____3324))
                     xs;
                   FStar_Util.string_builder_append strb "}";
                   FStar_Util.string_of_string_builder strb) in
            let uu____3326 =
              let uu____3331 =
                let uu____3332 = FStar_Syntax_Print.term_to_string t2 in
                let uu____3333 =
                  string_of_set FStar_Syntax_Print.bv_to_string s in
                FStar_Util.format2 "Dependency found in term %s : %s"
                  uu____3332 uu____3333 in
              (FStar_Errors.Warning_DependencyFound, uu____3331) in
            FStar_Errors.log_issue t2.FStar_Syntax_Syntax.pos uu____3326 in
          let rec is_non_dependent_arrow ty n1 =
            let uu____3341 =
              let uu____3342 = FStar_Syntax_Subst.compress ty in
              uu____3342.FStar_Syntax_Syntax.n in
            match uu____3341 with
            | FStar_Syntax_Syntax.Tm_arrow (binders,c) ->
                let uu____3363 =
                  let uu____3364 = FStar_Syntax_Util.is_tot_or_gtot_comp c in
                  Prims.op_Negation uu____3364 in
                if uu____3363
                then false
                else
                  (try
                     let non_dependent_or_raise s ty1 =
                       let sinter =
                         let uu____3390 = FStar_Syntax_Free.names ty1 in
                         FStar_Util.set_intersect uu____3390 s in
                       let uu____3393 =
                         let uu____3394 = FStar_Util.set_is_empty sinter in
                         Prims.op_Negation uu____3394 in
                       if uu____3393
                       then (debug1 ty1 sinter; FStar_Exn.raise Not_found)
                       else () in
                     let uu____3397 = FStar_Syntax_Subst.open_comp binders c in
                     match uu____3397 with
                     | (binders1,c1) ->
                         let s =
                           FStar_List.fold_left
                             (fun s  ->
                                fun uu____3419  ->
                                  match uu____3419 with
                                  | (bv,uu____3429) ->
                                      (non_dependent_or_raise s
                                         bv.FStar_Syntax_Syntax.sort;
                                       FStar_Util.set_add bv s))
                             FStar_Syntax_Syntax.no_names binders1 in
                         let ct = FStar_Syntax_Util.comp_result c1 in
                         (non_dependent_or_raise s ct;
                          (let k = n1 - (FStar_List.length binders1) in
                           if k > (Prims.parse_int "0")
                           then is_non_dependent_arrow ct k
                           else true))
                   with | Not_found  -> false)
            | uu____3443 ->
                ((let uu____3445 =
                    let uu____3450 =
                      let uu____3451 = FStar_Syntax_Print.term_to_string ty in
                      FStar_Util.format1 "Not a dependent arrow : %s"
                        uu____3451 in
                    (FStar_Errors.Warning_NotDependentArrow, uu____3450) in
                  FStar_Errors.log_issue ty.FStar_Syntax_Syntax.pos
                    uu____3445);
                 false) in
          let rec is_valid_application head2 =
            let uu____3456 =
              let uu____3457 = FStar_Syntax_Subst.compress head2 in
              uu____3457.FStar_Syntax_Syntax.n in
            match uu____3456 with
            | FStar_Syntax_Syntax.Tm_fvar fv when
                (((FStar_Syntax_Syntax.fv_eq_lid fv
                     FStar_Parser_Const.option_lid)
                    ||
                    (FStar_Syntax_Syntax.fv_eq_lid fv
                       FStar_Parser_Const.either_lid))
                   ||
                   (FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.eq2_lid))
                  ||
                  (let uu____3462 = FStar_Syntax_Subst.compress head2 in
                   FStar_Syntax_Util.is_tuple_constructor uu____3462)
                -> true
            | FStar_Syntax_Syntax.Tm_fvar fv ->
                let uu____3464 =
                  FStar_TypeChecker_Env.lookup_lid env.env
                    (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v in
                (match uu____3464 with
                 | ((uu____3473,ty),uu____3475) ->
                     let uu____3480 =
                       is_non_dependent_arrow ty (FStar_List.length args) in
                     if uu____3480
                     then
                       let res =
                         FStar_TypeChecker_Normalize.normalize
                           [FStar_TypeChecker_Normalize.Inlining;
                           FStar_TypeChecker_Normalize.UnfoldUntil
                             FStar_Syntax_Syntax.Delta_constant] env.env t1 in
                       (match res.FStar_Syntax_Syntax.n with
                        | FStar_Syntax_Syntax.Tm_app uu____3488 -> true
                        | uu____3503 ->
                            ((let uu____3505 =
                                let uu____3510 =
                                  let uu____3511 =
                                    FStar_Syntax_Print.term_to_string head2 in
                                  FStar_Util.format1
                                    "Got a term which might be a non-dependent user-defined data-type %s\n"
                                    uu____3511 in
                                (FStar_Errors.Warning_NondependentUserDefinedDataType,
                                  uu____3510) in
                              FStar_Errors.log_issue
                                head2.FStar_Syntax_Syntax.pos uu____3505);
                             false))
                     else false)
            | FStar_Syntax_Syntax.Tm_bvar uu____3513 -> true
            | FStar_Syntax_Syntax.Tm_name uu____3514 -> true
            | FStar_Syntax_Syntax.Tm_uinst (t2,uu____3516) ->
                is_valid_application t2
            | uu____3521 -> false in
          let uu____3522 = is_valid_application head1 in
          if uu____3522
          then
            let uu____3523 =
              let uu____3524 =
                let uu____3539 =
                  FStar_List.map
                    (fun uu____3560  ->
                       match uu____3560 with
                       | (t2,qual) ->
                           let uu____3577 = star_type' env t2 in
                           (uu____3577, qual)) args in
                (head1, uu____3539) in
              FStar_Syntax_Syntax.Tm_app uu____3524 in
            mk1 uu____3523
          else
            (let uu____3587 =
               let uu____3592 =
                 let uu____3593 = FStar_Syntax_Print.term_to_string t1 in
                 FStar_Util.format1
                   "For now, only [either], [option] and [eq2] are supported in the definition language (got: %s)"
                   uu____3593 in
               (FStar_Errors.Fatal_WrongTerm, uu____3592) in
             FStar_Errors.raise_err uu____3587)
      | FStar_Syntax_Syntax.Tm_bvar uu____3594 -> t1
      | FStar_Syntax_Syntax.Tm_name uu____3595 -> t1
      | FStar_Syntax_Syntax.Tm_type uu____3596 -> t1
      | FStar_Syntax_Syntax.Tm_fvar uu____3597 -> t1
      | FStar_Syntax_Syntax.Tm_abs (binders,repr,something) ->
          let uu____3621 = FStar_Syntax_Subst.open_term binders repr in
          (match uu____3621 with
           | (binders1,repr1) ->
               let env1 =
                 let uu___297_3629 = env in
                 let uu____3630 =
                   FStar_TypeChecker_Env.push_binders env.env binders1 in
                 {
                   env = uu____3630;
                   subst = (uu___297_3629.subst);
                   tc_const = (uu___297_3629.tc_const)
                 } in
               let repr2 = star_type' env1 repr1 in
               FStar_Syntax_Util.abs binders1 repr2 something)
      | FStar_Syntax_Syntax.Tm_refine (x,t2) when false ->
          let x1 = FStar_Syntax_Syntax.freshen_bv x in
          let sort = star_type' env x1.FStar_Syntax_Syntax.sort in
          let subst1 = [FStar_Syntax_Syntax.DB ((Prims.parse_int "0"), x1)] in
          let t3 = FStar_Syntax_Subst.subst subst1 t2 in
          let t4 = star_type' env t3 in
          let subst2 = [FStar_Syntax_Syntax.NM (x1, (Prims.parse_int "0"))] in
          let t5 = FStar_Syntax_Subst.subst subst2 t4 in
          mk1
            (FStar_Syntax_Syntax.Tm_refine
               ((let uu___298_3650 = x1 in
                 {
                   FStar_Syntax_Syntax.ppname =
                     (uu___298_3650.FStar_Syntax_Syntax.ppname);
                   FStar_Syntax_Syntax.index =
                     (uu___298_3650.FStar_Syntax_Syntax.index);
                   FStar_Syntax_Syntax.sort = sort
                 }), t5))
      | FStar_Syntax_Syntax.Tm_meta (t2,m) ->
          let uu____3657 =
            let uu____3658 =
              let uu____3665 = star_type' env t2 in (uu____3665, m) in
            FStar_Syntax_Syntax.Tm_meta uu____3658 in
          mk1 uu____3657
      | FStar_Syntax_Syntax.Tm_ascribed
          (e,(FStar_Util.Inl t2,FStar_Pervasives_Native.None ),something) ->
          let uu____3713 =
            let uu____3714 =
              let uu____3741 = star_type' env e in
              let uu____3742 =
                let uu____3757 =
                  let uu____3764 = star_type' env t2 in
                  FStar_Util.Inl uu____3764 in
                (uu____3757, FStar_Pervasives_Native.None) in
              (uu____3741, uu____3742, something) in
            FStar_Syntax_Syntax.Tm_ascribed uu____3714 in
          mk1 uu____3713
      | FStar_Syntax_Syntax.Tm_ascribed
          (e,(FStar_Util.Inr c,FStar_Pervasives_Native.None ),something) ->
          let uu____3842 =
            let uu____3843 =
              let uu____3870 = star_type' env e in
              let uu____3871 =
                let uu____3886 =
                  let uu____3893 =
                    star_type' env (FStar_Syntax_Util.comp_result c) in
                  FStar_Util.Inl uu____3893 in
                (uu____3886, FStar_Pervasives_Native.None) in
              (uu____3870, uu____3871, something) in
            FStar_Syntax_Syntax.Tm_ascribed uu____3843 in
          mk1 uu____3842
      | FStar_Syntax_Syntax.Tm_refine uu____3924 ->
          let uu____3931 =
            let uu____3936 =
              let uu____3937 = FStar_Syntax_Print.term_to_string t1 in
              FStar_Util.format1
                "Tm_refine is outside of the definition language: %s"
                uu____3937 in
            (FStar_Errors.Fatal_TermOutsideOfDefLanguage, uu____3936) in
          FStar_Errors.raise_err uu____3931
      | FStar_Syntax_Syntax.Tm_uinst uu____3938 ->
          let uu____3945 =
            let uu____3950 =
              let uu____3951 = FStar_Syntax_Print.term_to_string t1 in
              FStar_Util.format1
                "Tm_uinst is outside of the definition language: %s"
                uu____3951 in
            (FStar_Errors.Fatal_TermOutsideOfDefLanguage, uu____3950) in
          FStar_Errors.raise_err uu____3945
      | FStar_Syntax_Syntax.Tm_constant uu____3952 ->
          let uu____3953 =
            let uu____3958 =
              let uu____3959 = FStar_Syntax_Print.term_to_string t1 in
              FStar_Util.format1
                "Tm_constant is outside of the definition language: %s"
                uu____3959 in
            (FStar_Errors.Fatal_TermOutsideOfDefLanguage, uu____3958) in
          FStar_Errors.raise_err uu____3953
      | FStar_Syntax_Syntax.Tm_match uu____3960 ->
          let uu____3983 =
            let uu____3988 =
              let uu____3989 = FStar_Syntax_Print.term_to_string t1 in
              FStar_Util.format1
                "Tm_match is outside of the definition language: %s"
                uu____3989 in
            (FStar_Errors.Fatal_TermOutsideOfDefLanguage, uu____3988) in
          FStar_Errors.raise_err uu____3983
      | FStar_Syntax_Syntax.Tm_let uu____3990 ->
          let uu____4003 =
            let uu____4008 =
              let uu____4009 = FStar_Syntax_Print.term_to_string t1 in
              FStar_Util.format1
                "Tm_let is outside of the definition language: %s" uu____4009 in
            (FStar_Errors.Fatal_TermOutsideOfDefLanguage, uu____4008) in
          FStar_Errors.raise_err uu____4003
      | FStar_Syntax_Syntax.Tm_uvar uu____4010 ->
          let uu____4027 =
            let uu____4032 =
              let uu____4033 = FStar_Syntax_Print.term_to_string t1 in
              FStar_Util.format1
                "Tm_uvar is outside of the definition language: %s"
                uu____4033 in
            (FStar_Errors.Fatal_TermOutsideOfDefLanguage, uu____4032) in
          FStar_Errors.raise_err uu____4027
      | FStar_Syntax_Syntax.Tm_unknown  ->
          let uu____4034 =
            let uu____4039 =
              let uu____4040 = FStar_Syntax_Print.term_to_string t1 in
              FStar_Util.format1
                "Tm_unknown is outside of the definition language: %s"
                uu____4040 in
            (FStar_Errors.Fatal_TermOutsideOfDefLanguage, uu____4039) in
          FStar_Errors.raise_err uu____4034
      | FStar_Syntax_Syntax.Tm_delayed uu____4041 -> failwith "impossible"
let is_monadic:
  FStar_Syntax_Syntax.residual_comp FStar_Pervasives_Native.option ->
    Prims.bool
  =
  fun uu___282_4070  ->
    match uu___282_4070 with
    | FStar_Pervasives_Native.None  -> failwith "un-annotated lambda?!"
    | FStar_Pervasives_Native.Some rc ->
        FStar_All.pipe_right rc.FStar_Syntax_Syntax.residual_flags
          (FStar_Util.for_some
             (fun uu___281_4077  ->
                match uu___281_4077 with
                | FStar_Syntax_Syntax.CPS  -> true
                | uu____4078 -> false))
let rec is_C: FStar_Syntax_Syntax.typ -> Prims.bool =
  fun t  ->
    let uu____4082 =
      let uu____4083 = FStar_Syntax_Subst.compress t in
      uu____4083.FStar_Syntax_Syntax.n in
    match uu____4082 with
    | FStar_Syntax_Syntax.Tm_app (head1,args) when
        FStar_Syntax_Util.is_tuple_constructor head1 ->
        let r =
          let uu____4109 =
            let uu____4110 = FStar_List.hd args in
            FStar_Pervasives_Native.fst uu____4110 in
          is_C uu____4109 in
        if r
        then
          ((let uu____4126 =
              let uu____4127 =
                FStar_List.for_all
                  (fun uu____4135  ->
                     match uu____4135 with | (h,uu____4141) -> is_C h) args in
              Prims.op_Negation uu____4127 in
            if uu____4126 then failwith "not a C (A * C)" else ());
           true)
        else
          ((let uu____4145 =
              let uu____4146 =
                FStar_List.for_all
                  (fun uu____4155  ->
                     match uu____4155 with
                     | (h,uu____4161) ->
                         let uu____4162 = is_C h in
                         Prims.op_Negation uu____4162) args in
              Prims.op_Negation uu____4146 in
            if uu____4145 then failwith "not a C (C * A)" else ());
           false)
    | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
        let uu____4182 = nm_of_comp comp.FStar_Syntax_Syntax.n in
        (match uu____4182 with
         | M t1 ->
             ((let uu____4185 = is_C t1 in
               if uu____4185 then failwith "not a C (C -> C)" else ());
              true)
         | N t1 -> is_C t1)
    | FStar_Syntax_Syntax.Tm_meta (t1,uu____4189) -> is_C t1
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____4195) -> is_C t1
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____4201,uu____4202) -> is_C t1
    | uu____4243 -> false
let mk_return:
  env ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  fun env  ->
    fun t  ->
      fun e  ->
        let mk1 x =
          FStar_Syntax_Syntax.mk x FStar_Pervasives_Native.None
            e.FStar_Syntax_Syntax.pos in
        let p_type = mk_star_to_type mk1 env t in
        let p =
          FStar_Syntax_Syntax.gen_bv "p'" FStar_Pervasives_Native.None p_type in
        let body =
          let uu____4266 =
            let uu____4267 =
              let uu____4282 = FStar_Syntax_Syntax.bv_to_name p in
              let uu____4283 =
                let uu____4290 =
                  let uu____4295 = FStar_Syntax_Syntax.as_implicit false in
                  (e, uu____4295) in
                [uu____4290] in
              (uu____4282, uu____4283) in
            FStar_Syntax_Syntax.Tm_app uu____4267 in
          mk1 uu____4266 in
        let uu____4310 =
          let uu____4311 = FStar_Syntax_Syntax.mk_binder p in [uu____4311] in
        FStar_Syntax_Util.abs uu____4310 body
          (FStar_Pervasives_Native.Some
             (FStar_Syntax_Util.residual_tot FStar_Syntax_Util.ktype0))
let is_unknown: FStar_Syntax_Syntax.term' -> Prims.bool =
  fun uu___283_4314  ->
    match uu___283_4314 with
    | FStar_Syntax_Syntax.Tm_unknown  -> true
    | uu____4315 -> false
let rec check:
  env ->
    FStar_Syntax_Syntax.term ->
      nm ->
        (nm,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
          FStar_Pervasives_Native.tuple3
  =
  fun env  ->
    fun e  ->
      fun context_nm  ->
        let return_if uu____4490 =
          match uu____4490 with
          | (rec_nm,s_e,u_e) ->
              let check1 t1 t2 =
                let uu____4517 =
                  (Prims.op_Negation (is_unknown t2.FStar_Syntax_Syntax.n))
                    &&
                    (let uu____4519 =
                       let uu____4520 =
                         FStar_TypeChecker_Rel.teq env.env t1 t2 in
                       FStar_TypeChecker_Rel.is_trivial uu____4520 in
                     Prims.op_Negation uu____4519) in
                if uu____4517
                then
                  let uu____4521 =
                    let uu____4526 =
                      let uu____4527 = FStar_Syntax_Print.term_to_string e in
                      let uu____4528 = FStar_Syntax_Print.term_to_string t1 in
                      let uu____4529 = FStar_Syntax_Print.term_to_string t2 in
                      FStar_Util.format3
                        "[check]: the expression [%s] has type [%s] but should have type [%s]"
                        uu____4527 uu____4528 uu____4529 in
                    (FStar_Errors.Fatal_TypeMismatch, uu____4526) in
                  FStar_Errors.raise_err uu____4521
                else () in
              (match (rec_nm, context_nm) with
               | (N t1,N t2) -> (check1 t1 t2; (rec_nm, s_e, u_e))
               | (M t1,M t2) -> (check1 t1 t2; (rec_nm, s_e, u_e))
               | (N t1,M t2) ->
                   (check1 t1 t2;
                    (let uu____4546 = mk_return env t1 s_e in
                     ((M t1), uu____4546, u_e)))
               | (M t1,N t2) ->
                   let uu____4549 =
                     let uu____4554 =
                       let uu____4555 = FStar_Syntax_Print.term_to_string e in
                       let uu____4556 = FStar_Syntax_Print.term_to_string t1 in
                       let uu____4557 = FStar_Syntax_Print.term_to_string t2 in
                       FStar_Util.format3
                         "[check %s]: got an effectful computation [%s] in lieu of a pure computation [%s]"
                         uu____4555 uu____4556 uu____4557 in
                     (FStar_Errors.Fatal_EffectfulAndPureComputationMismatch,
                       uu____4554) in
                   FStar_Errors.raise_err uu____4549) in
        let ensure_m env1 e2 =
          let strip_m uu___284_4598 =
            match uu___284_4598 with
            | (M t,s_e,u_e) -> (t, s_e, u_e)
            | uu____4614 -> failwith "impossible" in
          match context_nm with
          | N t ->
              let uu____4634 =
                let uu____4639 =
                  let uu____4640 = FStar_Syntax_Print.term_to_string t in
                  Prims.strcat
                    "let-bound monadic body has a non-monadic continuation or a branch of a match is monadic and the others aren't : "
                    uu____4640 in
                (FStar_Errors.Fatal_LetBoundMonadicMismatch, uu____4639) in
              FStar_Errors.raise_error uu____4634 e2.FStar_Syntax_Syntax.pos
          | M uu____4647 ->
              let uu____4648 = check env1 e2 context_nm in strip_m uu____4648 in
        let uu____4655 =
          let uu____4656 = FStar_Syntax_Subst.compress e in
          uu____4656.FStar_Syntax_Syntax.n in
        match uu____4655 with
        | FStar_Syntax_Syntax.Tm_bvar uu____4665 ->
            let uu____4666 = infer env e in return_if uu____4666
        | FStar_Syntax_Syntax.Tm_name uu____4673 ->
            let uu____4674 = infer env e in return_if uu____4674
        | FStar_Syntax_Syntax.Tm_fvar uu____4681 ->
            let uu____4682 = infer env e in return_if uu____4682
        | FStar_Syntax_Syntax.Tm_abs uu____4689 ->
            let uu____4706 = infer env e in return_if uu____4706
        | FStar_Syntax_Syntax.Tm_constant uu____4713 ->
            let uu____4714 = infer env e in return_if uu____4714
        | FStar_Syntax_Syntax.Tm_app uu____4721 ->
            let uu____4736 = infer env e in return_if uu____4736
        | FStar_Syntax_Syntax.Tm_let ((false ,binding::[]),e2) ->
            mk_let env binding e2
              (fun env1  -> fun e21  -> check env1 e21 context_nm) ensure_m
        | FStar_Syntax_Syntax.Tm_match (e0,branches) ->
            mk_match env e0 branches
              (fun env1  -> fun body  -> check env1 body context_nm)
        | FStar_Syntax_Syntax.Tm_meta (e1,uu____4804) ->
            check env e1 context_nm
        | FStar_Syntax_Syntax.Tm_uinst (e1,uu____4810) ->
            check env e1 context_nm
        | FStar_Syntax_Syntax.Tm_ascribed (e1,uu____4816,uu____4817) ->
            check env e1 context_nm
        | FStar_Syntax_Syntax.Tm_let uu____4858 ->
            let uu____4871 =
              let uu____4872 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format1 "[check]: Tm_let %s" uu____4872 in
            failwith uu____4871
        | FStar_Syntax_Syntax.Tm_type uu____4879 ->
            failwith "impossible (DM stratification)"
        | FStar_Syntax_Syntax.Tm_arrow uu____4886 ->
            failwith "impossible (DM stratification)"
        | FStar_Syntax_Syntax.Tm_refine uu____4905 ->
            let uu____4912 =
              let uu____4913 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format1 "[check]: Tm_refine %s" uu____4913 in
            failwith uu____4912
        | FStar_Syntax_Syntax.Tm_uvar uu____4920 ->
            let uu____4937 =
              let uu____4938 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format1 "[check]: Tm_uvar %s" uu____4938 in
            failwith uu____4937
        | FStar_Syntax_Syntax.Tm_delayed uu____4945 ->
            failwith "impossible (compressed)"
        | FStar_Syntax_Syntax.Tm_unknown  ->
            let uu____4976 =
              let uu____4977 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format1 "[check]: Tm_unknown %s" uu____4977 in
            failwith uu____4976
and infer:
  env ->
    FStar_Syntax_Syntax.term ->
      (nm,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple3
  =
  fun env  ->
    fun e  ->
      let mk1 x =
        FStar_Syntax_Syntax.mk x FStar_Pervasives_Native.None
          e.FStar_Syntax_Syntax.pos in
      let normalize1 =
        FStar_TypeChecker_Normalize.normalize
          [FStar_TypeChecker_Normalize.Beta;
          FStar_TypeChecker_Normalize.Eager_unfolding;
          FStar_TypeChecker_Normalize.UnfoldUntil
            FStar_Syntax_Syntax.Delta_constant;
          FStar_TypeChecker_Normalize.EraseUniverses] env.env in
      let uu____5001 =
        let uu____5002 = FStar_Syntax_Subst.compress e in
        uu____5002.FStar_Syntax_Syntax.n in
      match uu____5001 with
      | FStar_Syntax_Syntax.Tm_bvar bv ->
          failwith "I failed to open a binder... boo"
      | FStar_Syntax_Syntax.Tm_name bv ->
          ((N (bv.FStar_Syntax_Syntax.sort)), e, e)
      | FStar_Syntax_Syntax.Tm_abs (binders,body,rc_opt) ->
          let subst_rc_opt subst1 rc_opt1 =
            match rc_opt1 with
            | FStar_Pervasives_Native.Some
                { FStar_Syntax_Syntax.residual_effect = uu____5061;
                  FStar_Syntax_Syntax.residual_typ =
                    FStar_Pervasives_Native.None ;
                  FStar_Syntax_Syntax.residual_flags = uu____5062;_}
                -> rc_opt1
            | FStar_Pervasives_Native.None  -> rc_opt1
            | FStar_Pervasives_Native.Some rc ->
                let uu____5068 =
                  let uu___299_5069 = rc in
                  let uu____5070 =
                    let uu____5075 =
                      let uu____5076 =
                        FStar_Util.must rc.FStar_Syntax_Syntax.residual_typ in
                      FStar_Syntax_Subst.subst subst1 uu____5076 in
                    FStar_Pervasives_Native.Some uu____5075 in
                  {
                    FStar_Syntax_Syntax.residual_effect =
                      (uu___299_5069.FStar_Syntax_Syntax.residual_effect);
                    FStar_Syntax_Syntax.residual_typ = uu____5070;
                    FStar_Syntax_Syntax.residual_flags =
                      (uu___299_5069.FStar_Syntax_Syntax.residual_flags)
                  } in
                FStar_Pervasives_Native.Some uu____5068 in
          let binders1 = FStar_Syntax_Subst.open_binders binders in
          let subst1 = FStar_Syntax_Subst.opening_of_binders binders1 in
          let body1 = FStar_Syntax_Subst.subst subst1 body in
          let rc_opt1 = subst_rc_opt subst1 rc_opt in
          let env1 =
            let uu___300_5086 = env in
            let uu____5087 =
              FStar_TypeChecker_Env.push_binders env.env binders1 in
            {
              env = uu____5087;
              subst = (uu___300_5086.subst);
              tc_const = (uu___300_5086.tc_const)
            } in
          let s_binders =
            FStar_List.map
              (fun uu____5107  ->
                 match uu____5107 with
                 | (bv,qual) ->
                     let sort = star_type' env1 bv.FStar_Syntax_Syntax.sort in
                     ((let uu___301_5120 = bv in
                       {
                         FStar_Syntax_Syntax.ppname =
                           (uu___301_5120.FStar_Syntax_Syntax.ppname);
                         FStar_Syntax_Syntax.index =
                           (uu___301_5120.FStar_Syntax_Syntax.index);
                         FStar_Syntax_Syntax.sort = sort
                       }), qual)) binders1 in
          let uu____5121 =
            FStar_List.fold_left
              (fun uu____5150  ->
                 fun uu____5151  ->
                   match (uu____5150, uu____5151) with
                   | ((env2,acc),(bv,qual)) ->
                       let c = bv.FStar_Syntax_Syntax.sort in
                       let uu____5199 = is_C c in
                       if uu____5199
                       then
                         let xw =
                           let uu____5207 = star_type' env2 c in
                           FStar_Syntax_Syntax.gen_bv
                             (Prims.strcat
                                (bv.FStar_Syntax_Syntax.ppname).FStar_Ident.idText
                                "__w") FStar_Pervasives_Native.None
                             uu____5207 in
                         let x =
                           let uu___302_5209 = bv in
                           let uu____5210 =
                             let uu____5213 =
                               FStar_Syntax_Syntax.bv_to_name xw in
                             trans_F_ env2 c uu____5213 in
                           {
                             FStar_Syntax_Syntax.ppname =
                               (uu___302_5209.FStar_Syntax_Syntax.ppname);
                             FStar_Syntax_Syntax.index =
                               (uu___302_5209.FStar_Syntax_Syntax.index);
                             FStar_Syntax_Syntax.sort = uu____5210
                           } in
                         let env3 =
                           let uu___303_5215 = env2 in
                           let uu____5216 =
                             let uu____5219 =
                               let uu____5220 =
                                 let uu____5227 =
                                   FStar_Syntax_Syntax.bv_to_name xw in
                                 (bv, uu____5227) in
                               FStar_Syntax_Syntax.NT uu____5220 in
                             uu____5219 :: (env2.subst) in
                           {
                             env = (uu___303_5215.env);
                             subst = uu____5216;
                             tc_const = (uu___303_5215.tc_const)
                           } in
                         let uu____5228 =
                           let uu____5231 = FStar_Syntax_Syntax.mk_binder x in
                           let uu____5232 =
                             let uu____5235 =
                               FStar_Syntax_Syntax.mk_binder xw in
                             uu____5235 :: acc in
                           uu____5231 :: uu____5232 in
                         (env3, uu____5228)
                       else
                         (let x =
                            let uu___304_5240 = bv in
                            let uu____5241 =
                              star_type' env2 bv.FStar_Syntax_Syntax.sort in
                            {
                              FStar_Syntax_Syntax.ppname =
                                (uu___304_5240.FStar_Syntax_Syntax.ppname);
                              FStar_Syntax_Syntax.index =
                                (uu___304_5240.FStar_Syntax_Syntax.index);
                              FStar_Syntax_Syntax.sort = uu____5241
                            } in
                          let uu____5244 =
                            let uu____5247 = FStar_Syntax_Syntax.mk_binder x in
                            uu____5247 :: acc in
                          (env2, uu____5244))) (env1, []) binders1 in
          (match uu____5121 with
           | (env2,u_binders) ->
               let u_binders1 = FStar_List.rev u_binders in
               let uu____5267 =
                 let check_what =
                   let uu____5285 = is_monadic rc_opt1 in
                   if uu____5285 then check_m else check_n in
                 let uu____5297 = check_what env2 body1 in
                 match uu____5297 with
                 | (t,s_body,u_body) ->
                     let uu____5313 =
                       let uu____5314 =
                         let uu____5315 = is_monadic rc_opt1 in
                         if uu____5315 then M t else N t in
                       comp_of_nm uu____5314 in
                     (uu____5313, s_body, u_body) in
               (match uu____5267 with
                | (comp,s_body,u_body) ->
                    let t = FStar_Syntax_Util.arrow binders1 comp in
                    let s_rc_opt =
                      match rc_opt1 with
                      | FStar_Pervasives_Native.None  ->
                          FStar_Pervasives_Native.None
                      | FStar_Pervasives_Native.Some rc ->
                          (match rc.FStar_Syntax_Syntax.residual_typ with
                           | FStar_Pervasives_Native.None  ->
                               let rc1 =
                                 let uu____5340 =
                                   FStar_All.pipe_right
                                     rc.FStar_Syntax_Syntax.residual_flags
                                     (FStar_Util.for_some
                                        (fun uu___285_5344  ->
                                           match uu___285_5344 with
                                           | FStar_Syntax_Syntax.CPS  -> true
                                           | uu____5345 -> false)) in
                                 if uu____5340
                                 then
                                   let uu____5346 =
                                     FStar_List.filter
                                       (fun uu___286_5350  ->
                                          match uu___286_5350 with
                                          | FStar_Syntax_Syntax.CPS  -> false
                                          | uu____5351 -> true)
                                       rc.FStar_Syntax_Syntax.residual_flags in
                                   FStar_Syntax_Util.mk_residual_comp
                                     FStar_Parser_Const.effect_Tot_lid
                                     FStar_Pervasives_Native.None uu____5346
                                 else rc in
                               FStar_Pervasives_Native.Some rc1
                           | FStar_Pervasives_Native.Some rt ->
                               let uu____5360 =
                                 FStar_All.pipe_right
                                   rc.FStar_Syntax_Syntax.residual_flags
                                   (FStar_Util.for_some
                                      (fun uu___287_5364  ->
                                         match uu___287_5364 with
                                         | FStar_Syntax_Syntax.CPS  -> true
                                         | uu____5365 -> false)) in
                               if uu____5360
                               then
                                 let flags1 =
                                   FStar_List.filter
                                     (fun uu___288_5372  ->
                                        match uu___288_5372 with
                                        | FStar_Syntax_Syntax.CPS  -> false
                                        | uu____5373 -> true)
                                     rc.FStar_Syntax_Syntax.residual_flags in
                                 let uu____5374 =
                                   let uu____5375 =
                                     let uu____5380 = double_star rt in
                                     FStar_Pervasives_Native.Some uu____5380 in
                                   FStar_Syntax_Util.mk_residual_comp
                                     FStar_Parser_Const.effect_Tot_lid
                                     uu____5375 flags1 in
                                 FStar_Pervasives_Native.Some uu____5374
                               else
                                 (let uu____5382 =
                                    let uu___305_5383 = rc in
                                    let uu____5384 =
                                      let uu____5389 = star_type' env2 rt in
                                      FStar_Pervasives_Native.Some uu____5389 in
                                    {
                                      FStar_Syntax_Syntax.residual_effect =
                                        (uu___305_5383.FStar_Syntax_Syntax.residual_effect);
                                      FStar_Syntax_Syntax.residual_typ =
                                        uu____5384;
                                      FStar_Syntax_Syntax.residual_flags =
                                        (uu___305_5383.FStar_Syntax_Syntax.residual_flags)
                                    } in
                                  FStar_Pervasives_Native.Some uu____5382)) in
                    let uu____5390 =
                      let comp1 =
                        let uu____5400 = is_monadic rc_opt1 in
                        let uu____5401 =
                          FStar_Syntax_Subst.subst env2.subst s_body in
                        trans_G env2 (FStar_Syntax_Util.comp_result comp)
                          uu____5400 uu____5401 in
                      let uu____5402 =
                        FStar_Syntax_Util.ascribe u_body
                          ((FStar_Util.Inr comp1),
                            FStar_Pervasives_Native.None) in
                      (uu____5402,
                        (FStar_Pervasives_Native.Some
                           (FStar_Syntax_Util.residual_comp_of_comp comp1))) in
                    (match uu____5390 with
                     | (u_body1,u_rc_opt) ->
                         let s_body1 =
                           FStar_Syntax_Subst.close s_binders s_body in
                         let s_binders1 =
                           FStar_Syntax_Subst.close_binders s_binders in
                         let s_term =
                           let uu____5444 =
                             let uu____5445 =
                               let uu____5462 =
                                 let uu____5465 =
                                   FStar_Syntax_Subst.closing_of_binders
                                     s_binders1 in
                                 subst_rc_opt uu____5465 s_rc_opt in
                               (s_binders1, s_body1, uu____5462) in
                             FStar_Syntax_Syntax.Tm_abs uu____5445 in
                           mk1 uu____5444 in
                         let u_body2 =
                           FStar_Syntax_Subst.close u_binders1 u_body1 in
                         let u_binders2 =
                           FStar_Syntax_Subst.close_binders u_binders1 in
                         let u_term =
                           let uu____5475 =
                             let uu____5476 =
                               let uu____5493 =
                                 let uu____5496 =
                                   FStar_Syntax_Subst.closing_of_binders
                                     u_binders2 in
                                 subst_rc_opt uu____5496 u_rc_opt in
                               (u_binders2, u_body2, uu____5493) in
                             FStar_Syntax_Syntax.Tm_abs uu____5476 in
                           mk1 uu____5475 in
                         ((N t), s_term, u_term))))
      | FStar_Syntax_Syntax.Tm_fvar
          {
            FStar_Syntax_Syntax.fv_name =
              { FStar_Syntax_Syntax.v = lid;
                FStar_Syntax_Syntax.p = uu____5506;_};
            FStar_Syntax_Syntax.fv_delta = uu____5507;
            FStar_Syntax_Syntax.fv_qual = uu____5508;_}
          ->
          let uu____5511 =
            let uu____5516 = FStar_TypeChecker_Env.lookup_lid env.env lid in
            FStar_All.pipe_left FStar_Pervasives_Native.fst uu____5516 in
          (match uu____5511 with
           | (uu____5547,t) ->
               let uu____5549 = let uu____5550 = normalize1 t in N uu____5550 in
               (uu____5549, e, e))
      | FStar_Syntax_Syntax.Tm_app
          ({
             FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
               (FStar_Const.Const_range_of );
             FStar_Syntax_Syntax.pos = uu____5551;
             FStar_Syntax_Syntax.vars = uu____5552;_},a::hd1::rest)
          ->
          let rest1 = hd1 :: rest in
          let uu____5615 = FStar_Syntax_Util.head_and_args e in
          (match uu____5615 with
           | (unary_op,uu____5637) ->
               let head1 = mk1 (FStar_Syntax_Syntax.Tm_app (unary_op, [a])) in
               let t = mk1 (FStar_Syntax_Syntax.Tm_app (head1, rest1)) in
               infer env t)
      | FStar_Syntax_Syntax.Tm_app
          ({
             FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
               (FStar_Const.Const_set_range_of );
             FStar_Syntax_Syntax.pos = uu____5696;
             FStar_Syntax_Syntax.vars = uu____5697;_},a1::a2::hd1::rest)
          ->
          let rest1 = hd1 :: rest in
          let uu____5773 = FStar_Syntax_Util.head_and_args e in
          (match uu____5773 with
           | (unary_op,uu____5795) ->
               let head1 =
                 mk1 (FStar_Syntax_Syntax.Tm_app (unary_op, [a1; a2])) in
               let t = mk1 (FStar_Syntax_Syntax.Tm_app (head1, rest1)) in
               infer env t)
      | FStar_Syntax_Syntax.Tm_app
          ({
             FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
               (FStar_Const.Const_range_of );
             FStar_Syntax_Syntax.pos = uu____5860;
             FStar_Syntax_Syntax.vars = uu____5861;_},(a,FStar_Pervasives_Native.None
                                                       )::[])
          ->
          let uu____5899 = infer env a in
          (match uu____5899 with
           | (t,s,u) ->
               let uu____5915 = FStar_Syntax_Util.head_and_args e in
               (match uu____5915 with
                | (head1,uu____5937) ->
                    let uu____5958 =
                      let uu____5959 =
                        FStar_Syntax_Syntax.tabbrev
                          FStar_Parser_Const.range_lid in
                      N uu____5959 in
                    let uu____5960 =
                      let uu____5963 =
                        let uu____5964 =
                          let uu____5979 =
                            let uu____5982 = FStar_Syntax_Syntax.as_arg s in
                            [uu____5982] in
                          (head1, uu____5979) in
                        FStar_Syntax_Syntax.Tm_app uu____5964 in
                      mk1 uu____5963 in
                    let uu____5987 =
                      let uu____5990 =
                        let uu____5991 =
                          let uu____6006 =
                            let uu____6009 = FStar_Syntax_Syntax.as_arg u in
                            [uu____6009] in
                          (head1, uu____6006) in
                        FStar_Syntax_Syntax.Tm_app uu____5991 in
                      mk1 uu____5990 in
                    (uu____5958, uu____5960, uu____5987)))
      | FStar_Syntax_Syntax.Tm_app
          ({
             FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
               (FStar_Const.Const_set_range_of );
             FStar_Syntax_Syntax.pos = uu____6018;
             FStar_Syntax_Syntax.vars = uu____6019;_},(a1,uu____6021)::a2::[])
          ->
          let uu____6063 = infer env a1 in
          (match uu____6063 with
           | (t,s,u) ->
               let uu____6079 = FStar_Syntax_Util.head_and_args e in
               (match uu____6079 with
                | (head1,uu____6101) ->
                    let uu____6122 =
                      let uu____6125 =
                        let uu____6126 =
                          let uu____6141 =
                            let uu____6144 = FStar_Syntax_Syntax.as_arg s in
                            [uu____6144; a2] in
                          (head1, uu____6141) in
                        FStar_Syntax_Syntax.Tm_app uu____6126 in
                      mk1 uu____6125 in
                    let uu____6161 =
                      let uu____6164 =
                        let uu____6165 =
                          let uu____6180 =
                            let uu____6183 = FStar_Syntax_Syntax.as_arg u in
                            [uu____6183; a2] in
                          (head1, uu____6180) in
                        FStar_Syntax_Syntax.Tm_app uu____6165 in
                      mk1 uu____6164 in
                    (t, uu____6122, uu____6161)))
      | FStar_Syntax_Syntax.Tm_app
          ({
             FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
               (FStar_Const.Const_range_of );
             FStar_Syntax_Syntax.pos = uu____6204;
             FStar_Syntax_Syntax.vars = uu____6205;_},uu____6206)
          ->
          let uu____6227 =
            let uu____6232 =
              let uu____6233 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format1 "DMFF: Ill-applied constant %s" uu____6233 in
            (FStar_Errors.Fatal_IllAppliedConstant, uu____6232) in
          FStar_Errors.raise_error uu____6227 e.FStar_Syntax_Syntax.pos
      | FStar_Syntax_Syntax.Tm_app
          ({
             FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
               (FStar_Const.Const_set_range_of );
             FStar_Syntax_Syntax.pos = uu____6240;
             FStar_Syntax_Syntax.vars = uu____6241;_},uu____6242)
          ->
          let uu____6263 =
            let uu____6268 =
              let uu____6269 = FStar_Syntax_Print.term_to_string e in
              FStar_Util.format1 "DMFF: Ill-applied constant %s" uu____6269 in
            (FStar_Errors.Fatal_IllAppliedConstant, uu____6268) in
          FStar_Errors.raise_error uu____6263 e.FStar_Syntax_Syntax.pos
      | FStar_Syntax_Syntax.Tm_app (head1,args) ->
          let uu____6298 = check_n env head1 in
          (match uu____6298 with
           | (t_head,s_head,u_head) ->
               let is_arrow t =
                 let uu____6318 =
                   let uu____6319 = FStar_Syntax_Subst.compress t in
                   uu____6319.FStar_Syntax_Syntax.n in
                 match uu____6318 with
                 | FStar_Syntax_Syntax.Tm_arrow uu____6322 -> true
                 | uu____6335 -> false in
               let rec flatten1 t =
                 let uu____6352 =
                   let uu____6353 = FStar_Syntax_Subst.compress t in
                   uu____6353.FStar_Syntax_Syntax.n in
                 match uu____6352 with
                 | FStar_Syntax_Syntax.Tm_arrow
                     (binders,{
                                FStar_Syntax_Syntax.n =
                                  FStar_Syntax_Syntax.Total (t1,uu____6370);
                                FStar_Syntax_Syntax.pos = uu____6371;
                                FStar_Syntax_Syntax.vars = uu____6372;_})
                     when is_arrow t1 ->
                     let uu____6397 = flatten1 t1 in
                     (match uu____6397 with
                      | (binders',comp) ->
                          ((FStar_List.append binders binders'), comp))
                 | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
                     (binders, comp)
                 | FStar_Syntax_Syntax.Tm_ascribed (e1,uu____6479,uu____6480)
                     -> flatten1 e1
                 | uu____6521 ->
                     let uu____6522 =
                       let uu____6527 =
                         let uu____6528 =
                           FStar_Syntax_Print.term_to_string t_head in
                         FStar_Util.format1 "%s: not a function type"
                           uu____6528 in
                       (FStar_Errors.Fatal_NotFunctionType, uu____6527) in
                     FStar_Errors.raise_err uu____6522 in
               let uu____6541 = flatten1 t_head in
               (match uu____6541 with
                | (binders,comp) ->
                    let n1 = FStar_List.length binders in
                    let n' = FStar_List.length args in
                    (if
                       (FStar_List.length binders) < (FStar_List.length args)
                     then
                       (let uu____6601 =
                          let uu____6606 =
                            let uu____6607 = FStar_Util.string_of_int n1 in
                            let uu____6614 =
                              FStar_Util.string_of_int (n' - n1) in
                            let uu____6625 = FStar_Util.string_of_int n1 in
                            FStar_Util.format3
                              "The head of this application, after being applied to %s arguments, is an effectful computation (leaving %s arguments to be applied). Please let-bind the head applied to the %s first arguments."
                              uu____6607 uu____6614 uu____6625 in
                          (FStar_Errors.Fatal_BinderAndArgsLengthMismatch,
                            uu____6606) in
                        FStar_Errors.raise_err uu____6601)
                     else ();
                     (let uu____6633 =
                        FStar_Syntax_Subst.open_comp binders comp in
                      match uu____6633 with
                      | (binders1,comp1) ->
                          let rec final_type subst1 uu____6674 args1 =
                            match uu____6674 with
                            | (binders2,comp2) ->
                                (match (binders2, args1) with
                                 | ([],[]) ->
                                     let uu____6748 =
                                       let uu____6749 =
                                         FStar_Syntax_Subst.subst_comp subst1
                                           comp2 in
                                       uu____6749.FStar_Syntax_Syntax.n in
                                     nm_of_comp uu____6748
                                 | (binders3,[]) ->
                                     let uu____6779 =
                                       let uu____6780 =
                                         let uu____6783 =
                                           let uu____6784 =
                                             mk1
                                               (FStar_Syntax_Syntax.Tm_arrow
                                                  (binders3, comp2)) in
                                           FStar_Syntax_Subst.subst subst1
                                             uu____6784 in
                                         FStar_Syntax_Subst.compress
                                           uu____6783 in
                                       uu____6780.FStar_Syntax_Syntax.n in
                                     (match uu____6779 with
                                      | FStar_Syntax_Syntax.Tm_arrow
                                          (binders4,comp3) ->
                                          let uu____6809 =
                                            let uu____6810 =
                                              let uu____6811 =
                                                let uu____6824 =
                                                  FStar_Syntax_Subst.close_comp
                                                    binders4 comp3 in
                                                (binders4, uu____6824) in
                                              FStar_Syntax_Syntax.Tm_arrow
                                                uu____6811 in
                                            mk1 uu____6810 in
                                          N uu____6809
                                      | uu____6831 -> failwith "wat?")
                                 | ([],uu____6832::uu____6833) ->
                                     failwith "just checked that?!"
                                 | ((bv,uu____6873)::binders3,(arg,uu____6876)::args2)
                                     ->
                                     final_type
                                       ((FStar_Syntax_Syntax.NT (bv, arg)) ::
                                       subst1) (binders3, comp2) args2) in
                          let final_type1 =
                            final_type [] (binders1, comp1) args in
                          let uu____6929 = FStar_List.splitAt n' binders1 in
                          (match uu____6929 with
                           | (binders2,uu____6961) ->
                               let uu____6986 =
                                 let uu____7005 =
                                   FStar_List.map2
                                     (fun uu____7053  ->
                                        fun uu____7054  ->
                                          match (uu____7053, uu____7054) with
                                          | ((bv,uu____7086),(arg,q)) ->
                                              let uu____7097 =
                                                let uu____7098 =
                                                  FStar_Syntax_Subst.compress
                                                    bv.FStar_Syntax_Syntax.sort in
                                                uu____7098.FStar_Syntax_Syntax.n in
                                              (match uu____7097 with
                                               | FStar_Syntax_Syntax.Tm_type
                                                   uu____7115 ->
                                                   let arg1 = (arg, q) in
                                                   (arg1, [arg1])
                                               | uu____7139 ->
                                                   let uu____7140 =
                                                     check_n env arg in
                                                   (match uu____7140 with
                                                    | (uu____7161,s_arg,u_arg)
                                                        ->
                                                        let uu____7164 =
                                                          let uu____7171 =
                                                            is_C
                                                              bv.FStar_Syntax_Syntax.sort in
                                                          if uu____7171
                                                          then
                                                            let uu____7178 =
                                                              let uu____7183
                                                                =
                                                                FStar_Syntax_Subst.subst
                                                                  env.subst
                                                                  s_arg in
                                                              (uu____7183, q) in
                                                            [uu____7178;
                                                            (u_arg, q)]
                                                          else [(u_arg, q)] in
                                                        ((s_arg, q),
                                                          uu____7164))))
                                     binders2 args in
                                 FStar_List.split uu____7005 in
                               (match uu____6986 with
                                | (s_args,u_args) ->
                                    let u_args1 = FStar_List.flatten u_args in
                                    let uu____7272 =
                                      mk1
                                        (FStar_Syntax_Syntax.Tm_app
                                           (s_head, s_args)) in
                                    let uu____7281 =
                                      mk1
                                        (FStar_Syntax_Syntax.Tm_app
                                           (u_head, u_args1)) in
                                    (final_type1, uu____7272, uu____7281)))))))
      | FStar_Syntax_Syntax.Tm_let ((false ,binding::[]),e2) ->
          mk_let env binding e2 infer check_m
      | FStar_Syntax_Syntax.Tm_match (e0,branches) ->
          mk_match env e0 branches infer
      | FStar_Syntax_Syntax.Tm_uinst (e1,uu____7347) -> infer env e1
      | FStar_Syntax_Syntax.Tm_meta (e1,uu____7353) -> infer env e1
      | FStar_Syntax_Syntax.Tm_ascribed (e1,uu____7359,uu____7360) ->
          infer env e1
      | FStar_Syntax_Syntax.Tm_constant c ->
          let uu____7402 = let uu____7403 = env.tc_const c in N uu____7403 in
          (uu____7402, e, e)
      | FStar_Syntax_Syntax.Tm_let uu____7404 ->
          let uu____7417 =
            let uu____7418 = FStar_Syntax_Print.term_to_string e in
            FStar_Util.format1 "[infer]: Tm_let %s" uu____7418 in
          failwith uu____7417
      | FStar_Syntax_Syntax.Tm_type uu____7425 ->
          failwith "impossible (DM stratification)"
      | FStar_Syntax_Syntax.Tm_arrow uu____7432 ->
          failwith "impossible (DM stratification)"
      | FStar_Syntax_Syntax.Tm_refine uu____7451 ->
          let uu____7458 =
            let uu____7459 = FStar_Syntax_Print.term_to_string e in
            FStar_Util.format1 "[infer]: Tm_refine %s" uu____7459 in
          failwith uu____7458
      | FStar_Syntax_Syntax.Tm_uvar uu____7466 ->
          let uu____7483 =
            let uu____7484 = FStar_Syntax_Print.term_to_string e in
            FStar_Util.format1 "[infer]: Tm_uvar %s" uu____7484 in
          failwith uu____7483
      | FStar_Syntax_Syntax.Tm_delayed uu____7491 ->
          failwith "impossible (compressed)"
      | FStar_Syntax_Syntax.Tm_unknown  ->
          let uu____7522 =
            let uu____7523 = FStar_Syntax_Print.term_to_string e in
            FStar_Util.format1 "[infer]: Tm_unknown %s" uu____7523 in
          failwith uu____7522
and mk_match:
  env ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                                 FStar_Syntax_Syntax.syntax
                                                                 FStar_Pervasives_Native.option,
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
        FStar_Pervasives_Native.tuple3 Prims.list ->
        (env ->
           FStar_Syntax_Syntax.term ->
             (nm,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
               FStar_Pervasives_Native.tuple3)
          ->
          (nm,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
            FStar_Pervasives_Native.tuple3
  =
  fun env  ->
    fun e0  ->
      fun branches  ->
        fun f  ->
          let mk1 x =
            FStar_Syntax_Syntax.mk x FStar_Pervasives_Native.None
              e0.FStar_Syntax_Syntax.pos in
          let uu____7568 = check_n env e0 in
          match uu____7568 with
          | (uu____7581,s_e0,u_e0) ->
              let uu____7584 =
                let uu____7613 =
                  FStar_List.map
                    (fun b  ->
                       let uu____7674 = FStar_Syntax_Subst.open_branch b in
                       match uu____7674 with
                       | (pat,FStar_Pervasives_Native.None ,body) ->
                           let env1 =
                             let uu___306_7716 = env in
                             let uu____7717 =
                               let uu____7718 =
                                 FStar_Syntax_Syntax.pat_bvs pat in
                               FStar_List.fold_left
                                 FStar_TypeChecker_Env.push_bv env.env
                                 uu____7718 in
                             {
                               env = uu____7717;
                               subst = (uu___306_7716.subst);
                               tc_const = (uu___306_7716.tc_const)
                             } in
                           let uu____7721 = f env1 body in
                           (match uu____7721 with
                            | (nm,s_body,u_body) ->
                                (nm,
                                  (pat, FStar_Pervasives_Native.None,
                                    (s_body, u_body, body))))
                       | uu____7793 ->
                           FStar_Errors.raise_err
                             (FStar_Errors.WhenClauseFatal_NotSupported,
                               "No when clauses in the definition language"))
                    branches in
                FStar_List.split uu____7613 in
              (match uu____7584 with
               | (nms,branches1) ->
                   let t1 =
                     let uu____7895 = FStar_List.hd nms in
                     match uu____7895 with | M t1 -> t1 | N t1 -> t1 in
                   let has_m =
                     FStar_List.existsb
                       (fun uu___289_7901  ->
                          match uu___289_7901 with
                          | M uu____7902 -> true
                          | uu____7903 -> false) nms in
                   let uu____7904 =
                     let uu____7941 =
                       FStar_List.map2
                         (fun nm  ->
                            fun uu____8031  ->
                              match uu____8031 with
                              | (pat,guard,(s_body,u_body,original_body)) ->
                                  (match (nm, has_m) with
                                   | (N t2,false ) ->
                                       (nm, (pat, guard, s_body),
                                         (pat, guard, u_body))
                                   | (M t2,true ) ->
                                       (nm, (pat, guard, s_body),
                                         (pat, guard, u_body))
                                   | (N t2,true ) ->
                                       let uu____8208 =
                                         check env original_body (M t2) in
                                       (match uu____8208 with
                                        | (uu____8245,s_body1,u_body1) ->
                                            ((M t2), (pat, guard, s_body1),
                                              (pat, guard, u_body1)))
                                   | (M uu____8284,false ) ->
                                       failwith "impossible")) nms branches1 in
                     FStar_List.unzip3 uu____7941 in
                   (match uu____7904 with
                    | (nms1,s_branches,u_branches) ->
                        if has_m
                        then
                          let p_type = mk_star_to_type mk1 env t1 in
                          let p =
                            FStar_Syntax_Syntax.gen_bv "p''"
                              FStar_Pervasives_Native.None p_type in
                          let s_branches1 =
                            FStar_List.map
                              (fun uu____8468  ->
                                 match uu____8468 with
                                 | (pat,guard,s_body) ->
                                     let s_body1 =
                                       let uu____8519 =
                                         let uu____8520 =
                                           let uu____8535 =
                                             let uu____8542 =
                                               let uu____8547 =
                                                 FStar_Syntax_Syntax.bv_to_name
                                                   p in
                                               let uu____8548 =
                                                 FStar_Syntax_Syntax.as_implicit
                                                   false in
                                               (uu____8547, uu____8548) in
                                             [uu____8542] in
                                           (s_body, uu____8535) in
                                         FStar_Syntax_Syntax.Tm_app
                                           uu____8520 in
                                       mk1 uu____8519 in
                                     (pat, guard, s_body1)) s_branches in
                          let s_branches2 =
                            FStar_List.map FStar_Syntax_Subst.close_branch
                              s_branches1 in
                          let u_branches1 =
                            FStar_List.map FStar_Syntax_Subst.close_branch
                              u_branches in
                          let s_e =
                            let uu____8580 =
                              let uu____8581 =
                                FStar_Syntax_Syntax.mk_binder p in
                              [uu____8581] in
                            let uu____8582 =
                              mk1
                                (FStar_Syntax_Syntax.Tm_match
                                   (s_e0, s_branches2)) in
                            FStar_Syntax_Util.abs uu____8580 uu____8582
                              (FStar_Pervasives_Native.Some
                                 (FStar_Syntax_Util.residual_tot
                                    FStar_Syntax_Util.ktype0)) in
                          let t1_star =
                            let uu____8588 =
                              let uu____8595 =
                                let uu____8596 =
                                  FStar_Syntax_Syntax.new_bv
                                    FStar_Pervasives_Native.None p_type in
                                FStar_All.pipe_left
                                  FStar_Syntax_Syntax.mk_binder uu____8596 in
                              [uu____8595] in
                            let uu____8597 =
                              FStar_Syntax_Syntax.mk_Total
                                FStar_Syntax_Util.ktype0 in
                            FStar_Syntax_Util.arrow uu____8588 uu____8597 in
                          let uu____8600 =
                            mk1
                              (FStar_Syntax_Syntax.Tm_ascribed
                                 (s_e,
                                   ((FStar_Util.Inl t1_star),
                                     FStar_Pervasives_Native.None),
                                   FStar_Pervasives_Native.None)) in
                          let uu____8639 =
                            mk1
                              (FStar_Syntax_Syntax.Tm_match
                                 (u_e0, u_branches1)) in
                          ((M t1), uu____8600, uu____8639)
                        else
                          (let s_branches1 =
                             FStar_List.map FStar_Syntax_Subst.close_branch
                               s_branches in
                           let u_branches1 =
                             FStar_List.map FStar_Syntax_Subst.close_branch
                               u_branches in
                           let t1_star = t1 in
                           let uu____8656 =
                             let uu____8659 =
                               let uu____8660 =
                                 let uu____8687 =
                                   mk1
                                     (FStar_Syntax_Syntax.Tm_match
                                        (s_e0, s_branches1)) in
                                 (uu____8687,
                                   ((FStar_Util.Inl t1_star),
                                     FStar_Pervasives_Native.None),
                                   FStar_Pervasives_Native.None) in
                               FStar_Syntax_Syntax.Tm_ascribed uu____8660 in
                             mk1 uu____8659 in
                           let uu____8724 =
                             mk1
                               (FStar_Syntax_Syntax.Tm_match
                                  (u_e0, u_branches1)) in
                           ((N t1), uu____8656, uu____8724))))
and mk_let:
  env_ ->
    FStar_Syntax_Syntax.letbinding ->
      FStar_Syntax_Syntax.term ->
        (env_ ->
           FStar_Syntax_Syntax.term ->
             (nm,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
               FStar_Pervasives_Native.tuple3)
          ->
          (env_ ->
             FStar_Syntax_Syntax.term ->
               (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
                 FStar_Pervasives_Native.tuple3)
            ->
            (nm,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
              FStar_Pervasives_Native.tuple3
  =
  fun env  ->
    fun binding  ->
      fun e2  ->
        fun proceed  ->
          fun ensure_m  ->
            let mk1 x =
              FStar_Syntax_Syntax.mk x FStar_Pervasives_Native.None
                e2.FStar_Syntax_Syntax.pos in
            let e1 = binding.FStar_Syntax_Syntax.lbdef in
            let x = FStar_Util.left binding.FStar_Syntax_Syntax.lbname in
            let x_binders =
              let uu____8771 = FStar_Syntax_Syntax.mk_binder x in
              [uu____8771] in
            let uu____8772 = FStar_Syntax_Subst.open_term x_binders e2 in
            match uu____8772 with
            | (x_binders1,e21) ->
                let uu____8785 = infer env e1 in
                (match uu____8785 with
                 | (N t1,s_e1,u_e1) ->
                     let u_binding =
                       let uu____8802 = is_C t1 in
                       if uu____8802
                       then
                         let uu___307_8803 = binding in
                         let uu____8804 =
                           let uu____8807 =
                             FStar_Syntax_Subst.subst env.subst s_e1 in
                           trans_F_ env t1 uu____8807 in
                         {
                           FStar_Syntax_Syntax.lbname =
                             (uu___307_8803.FStar_Syntax_Syntax.lbname);
                           FStar_Syntax_Syntax.lbunivs =
                             (uu___307_8803.FStar_Syntax_Syntax.lbunivs);
                           FStar_Syntax_Syntax.lbtyp = uu____8804;
                           FStar_Syntax_Syntax.lbeff =
                             (uu___307_8803.FStar_Syntax_Syntax.lbeff);
                           FStar_Syntax_Syntax.lbdef =
                             (uu___307_8803.FStar_Syntax_Syntax.lbdef)
                         }
                       else binding in
                     let env1 =
                       let uu___308_8810 = env in
                       let uu____8811 =
                         FStar_TypeChecker_Env.push_bv env.env
                           (let uu___309_8813 = x in
                            {
                              FStar_Syntax_Syntax.ppname =
                                (uu___309_8813.FStar_Syntax_Syntax.ppname);
                              FStar_Syntax_Syntax.index =
                                (uu___309_8813.FStar_Syntax_Syntax.index);
                              FStar_Syntax_Syntax.sort = t1
                            }) in
                       {
                         env = uu____8811;
                         subst = (uu___308_8810.subst);
                         tc_const = (uu___308_8810.tc_const)
                       } in
                     let uu____8814 = proceed env1 e21 in
                     (match uu____8814 with
                      | (nm_rec,s_e2,u_e2) ->
                          let s_binding =
                            let uu___310_8831 = binding in
                            let uu____8832 =
                              star_type' env1
                                binding.FStar_Syntax_Syntax.lbtyp in
                            {
                              FStar_Syntax_Syntax.lbname =
                                (uu___310_8831.FStar_Syntax_Syntax.lbname);
                              FStar_Syntax_Syntax.lbunivs =
                                (uu___310_8831.FStar_Syntax_Syntax.lbunivs);
                              FStar_Syntax_Syntax.lbtyp = uu____8832;
                              FStar_Syntax_Syntax.lbeff =
                                (uu___310_8831.FStar_Syntax_Syntax.lbeff);
                              FStar_Syntax_Syntax.lbdef =
                                (uu___310_8831.FStar_Syntax_Syntax.lbdef)
                            } in
                          let uu____8835 =
                            let uu____8838 =
                              let uu____8839 =
                                let uu____8852 =
                                  FStar_Syntax_Subst.close x_binders1 s_e2 in
                                ((false,
                                   [(let uu___311_8862 = s_binding in
                                     {
                                       FStar_Syntax_Syntax.lbname =
                                         (uu___311_8862.FStar_Syntax_Syntax.lbname);
                                       FStar_Syntax_Syntax.lbunivs =
                                         (uu___311_8862.FStar_Syntax_Syntax.lbunivs);
                                       FStar_Syntax_Syntax.lbtyp =
                                         (uu___311_8862.FStar_Syntax_Syntax.lbtyp);
                                       FStar_Syntax_Syntax.lbeff =
                                         (uu___311_8862.FStar_Syntax_Syntax.lbeff);
                                       FStar_Syntax_Syntax.lbdef = s_e1
                                     })]), uu____8852) in
                              FStar_Syntax_Syntax.Tm_let uu____8839 in
                            mk1 uu____8838 in
                          let uu____8863 =
                            let uu____8866 =
                              let uu____8867 =
                                let uu____8880 =
                                  FStar_Syntax_Subst.close x_binders1 u_e2 in
                                ((false,
                                   [(let uu___312_8890 = u_binding in
                                     {
                                       FStar_Syntax_Syntax.lbname =
                                         (uu___312_8890.FStar_Syntax_Syntax.lbname);
                                       FStar_Syntax_Syntax.lbunivs =
                                         (uu___312_8890.FStar_Syntax_Syntax.lbunivs);
                                       FStar_Syntax_Syntax.lbtyp =
                                         (uu___312_8890.FStar_Syntax_Syntax.lbtyp);
                                       FStar_Syntax_Syntax.lbeff =
                                         (uu___312_8890.FStar_Syntax_Syntax.lbeff);
                                       FStar_Syntax_Syntax.lbdef = u_e1
                                     })]), uu____8880) in
                              FStar_Syntax_Syntax.Tm_let uu____8867 in
                            mk1 uu____8866 in
                          (nm_rec, uu____8835, uu____8863))
                 | (M t1,s_e1,u_e1) ->
                     let u_binding =
                       let uu___313_8899 = binding in
                       {
                         FStar_Syntax_Syntax.lbname =
                           (uu___313_8899.FStar_Syntax_Syntax.lbname);
                         FStar_Syntax_Syntax.lbunivs =
                           (uu___313_8899.FStar_Syntax_Syntax.lbunivs);
                         FStar_Syntax_Syntax.lbtyp = t1;
                         FStar_Syntax_Syntax.lbeff =
                           FStar_Parser_Const.effect_PURE_lid;
                         FStar_Syntax_Syntax.lbdef =
                           (uu___313_8899.FStar_Syntax_Syntax.lbdef)
                       } in
                     let env1 =
                       let uu___314_8901 = env in
                       let uu____8902 =
                         FStar_TypeChecker_Env.push_bv env.env
                           (let uu___315_8904 = x in
                            {
                              FStar_Syntax_Syntax.ppname =
                                (uu___315_8904.FStar_Syntax_Syntax.ppname);
                              FStar_Syntax_Syntax.index =
                                (uu___315_8904.FStar_Syntax_Syntax.index);
                              FStar_Syntax_Syntax.sort = t1
                            }) in
                       {
                         env = uu____8902;
                         subst = (uu___314_8901.subst);
                         tc_const = (uu___314_8901.tc_const)
                       } in
                     let uu____8905 = ensure_m env1 e21 in
                     (match uu____8905 with
                      | (t2,s_e2,u_e2) ->
                          let p_type = mk_star_to_type mk1 env1 t2 in
                          let p =
                            FStar_Syntax_Syntax.gen_bv "p''"
                              FStar_Pervasives_Native.None p_type in
                          let s_e21 =
                            let uu____8928 =
                              let uu____8929 =
                                let uu____8944 =
                                  let uu____8951 =
                                    let uu____8956 =
                                      FStar_Syntax_Syntax.bv_to_name p in
                                    let uu____8957 =
                                      FStar_Syntax_Syntax.as_implicit false in
                                    (uu____8956, uu____8957) in
                                  [uu____8951] in
                                (s_e2, uu____8944) in
                              FStar_Syntax_Syntax.Tm_app uu____8929 in
                            mk1 uu____8928 in
                          let s_e22 =
                            FStar_Syntax_Util.abs x_binders1 s_e21
                              (FStar_Pervasives_Native.Some
                                 (FStar_Syntax_Util.residual_tot
                                    FStar_Syntax_Util.ktype0)) in
                          let body =
                            let uu____8976 =
                              let uu____8977 =
                                let uu____8992 =
                                  let uu____8999 =
                                    let uu____9004 =
                                      FStar_Syntax_Syntax.as_implicit false in
                                    (s_e22, uu____9004) in
                                  [uu____8999] in
                                (s_e1, uu____8992) in
                              FStar_Syntax_Syntax.Tm_app uu____8977 in
                            mk1 uu____8976 in
                          let uu____9019 =
                            let uu____9020 =
                              let uu____9021 =
                                FStar_Syntax_Syntax.mk_binder p in
                              [uu____9021] in
                            FStar_Syntax_Util.abs uu____9020 body
                              (FStar_Pervasives_Native.Some
                                 (FStar_Syntax_Util.residual_tot
                                    FStar_Syntax_Util.ktype0)) in
                          let uu____9022 =
                            let uu____9025 =
                              let uu____9026 =
                                let uu____9039 =
                                  FStar_Syntax_Subst.close x_binders1 u_e2 in
                                ((false,
                                   [(let uu___316_9049 = u_binding in
                                     {
                                       FStar_Syntax_Syntax.lbname =
                                         (uu___316_9049.FStar_Syntax_Syntax.lbname);
                                       FStar_Syntax_Syntax.lbunivs =
                                         (uu___316_9049.FStar_Syntax_Syntax.lbunivs);
                                       FStar_Syntax_Syntax.lbtyp =
                                         (uu___316_9049.FStar_Syntax_Syntax.lbtyp);
                                       FStar_Syntax_Syntax.lbeff =
                                         (uu___316_9049.FStar_Syntax_Syntax.lbeff);
                                       FStar_Syntax_Syntax.lbdef = u_e1
                                     })]), uu____9039) in
                              FStar_Syntax_Syntax.Tm_let uu____9026 in
                            mk1 uu____9025 in
                          ((M t2), uu____9019, uu____9022)))
and check_n:
  env_ ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple3
  =
  fun env  ->
    fun e  ->
      let mn =
        let uu____9061 =
          FStar_Syntax_Syntax.mk FStar_Syntax_Syntax.Tm_unknown
            FStar_Pervasives_Native.None e.FStar_Syntax_Syntax.pos in
        N uu____9061 in
      let uu____9062 = check env e mn in
      match uu____9062 with
      | (N t,s_e,u_e) -> (t, s_e, u_e)
      | uu____9078 -> failwith "[check_n]: impossible"
and check_m:
  env_ ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple3
  =
  fun env  ->
    fun e  ->
      let mn =
        let uu____9100 =
          FStar_Syntax_Syntax.mk FStar_Syntax_Syntax.Tm_unknown
            FStar_Pervasives_Native.None e.FStar_Syntax_Syntax.pos in
        M uu____9100 in
      let uu____9101 = check env e mn in
      match uu____9101 with
      | (M t,s_e,u_e) -> (t, s_e, u_e)
      | uu____9117 -> failwith "[check_m]: impossible"
and comp_of_nm: nm_ -> FStar_Syntax_Syntax.comp =
  fun nm  ->
    match nm with | N t -> FStar_Syntax_Syntax.mk_Total t | M t -> mk_M t
and mk_M: FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.comp =
  fun t  ->
    FStar_Syntax_Syntax.mk_Comp
      {
        FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_unknown];
        FStar_Syntax_Syntax.effect_name = FStar_Parser_Const.monadic_lid;
        FStar_Syntax_Syntax.result_typ = t;
        FStar_Syntax_Syntax.effect_args = [];
        FStar_Syntax_Syntax.flags =
          [FStar_Syntax_Syntax.CPS; FStar_Syntax_Syntax.TOTAL]
      }
and type_of_comp:
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
  = fun t  -> FStar_Syntax_Util.comp_result t
and trans_F_:
  env_ ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  fun env  ->
    fun c  ->
      fun wp  ->
        (let uu____9147 =
           let uu____9148 = is_C c in Prims.op_Negation uu____9148 in
         if uu____9147 then failwith "not a C" else ());
        (let mk1 x =
           FStar_Syntax_Syntax.mk x FStar_Pervasives_Native.None
             c.FStar_Syntax_Syntax.pos in
         let uu____9156 =
           let uu____9157 = FStar_Syntax_Subst.compress c in
           uu____9157.FStar_Syntax_Syntax.n in
         match uu____9156 with
         | FStar_Syntax_Syntax.Tm_app (head1,args) ->
             let uu____9182 = FStar_Syntax_Util.head_and_args wp in
             (match uu____9182 with
              | (wp_head,wp_args) ->
                  ((let uu____9220 =
                      (Prims.op_Negation
                         ((FStar_List.length wp_args) =
                            (FStar_List.length args)))
                        ||
                        (let uu____9234 =
                           let uu____9235 =
                             FStar_Parser_Const.mk_tuple_data_lid
                               (FStar_List.length wp_args)
                               FStar_Range.dummyRange in
                           FStar_Syntax_Util.is_constructor wp_head
                             uu____9235 in
                         Prims.op_Negation uu____9234) in
                    if uu____9220 then failwith "mismatch" else ());
                   (let uu____9243 =
                      let uu____9244 =
                        let uu____9259 =
                          FStar_List.map2
                            (fun uu____9287  ->
                               fun uu____9288  ->
                                 match (uu____9287, uu____9288) with
                                 | ((arg,q),(wp_arg,q')) ->
                                     let print_implicit q1 =
                                       let uu____9325 =
                                         FStar_Syntax_Syntax.is_implicit q1 in
                                       if uu____9325
                                       then "implicit"
                                       else "explicit" in
                                     (if q <> q'
                                      then
                                        (let uu____9328 =
                                           let uu____9333 =
                                             let uu____9334 =
                                               print_implicit q in
                                             let uu____9335 =
                                               print_implicit q' in
                                             FStar_Util.format2
                                               "Incoherent implicit qualifiers %b %b\n"
                                               uu____9334 uu____9335 in
                                           (FStar_Errors.Warning_IncoherentImplicitQualifier,
                                             uu____9333) in
                                         FStar_Errors.log_issue
                                           head1.FStar_Syntax_Syntax.pos
                                           uu____9328)
                                      else ();
                                      (let uu____9337 =
                                         trans_F_ env arg wp_arg in
                                       (uu____9337, q)))) args wp_args in
                        (head1, uu____9259) in
                      FStar_Syntax_Syntax.Tm_app uu____9244 in
                    mk1 uu____9243)))
         | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
             let binders1 = FStar_Syntax_Util.name_binders binders in
             let uu____9371 = FStar_Syntax_Subst.open_comp binders1 comp in
             (match uu____9371 with
              | (binders_orig,comp1) ->
                  let uu____9378 =
                    let uu____9393 =
                      FStar_List.map
                        (fun uu____9427  ->
                           match uu____9427 with
                           | (bv,q) ->
                               let h = bv.FStar_Syntax_Syntax.sort in
                               let uu____9447 = is_C h in
                               if uu____9447
                               then
                                 let w' =
                                   let uu____9459 = star_type' env h in
                                   FStar_Syntax_Syntax.gen_bv
                                     (Prims.strcat
                                        (bv.FStar_Syntax_Syntax.ppname).FStar_Ident.idText
                                        "__w'") FStar_Pervasives_Native.None
                                     uu____9459 in
                                 let uu____9460 =
                                   let uu____9467 =
                                     let uu____9474 =
                                       let uu____9479 =
                                         let uu____9480 =
                                           let uu____9481 =
                                             FStar_Syntax_Syntax.bv_to_name
                                               w' in
                                           trans_F_ env h uu____9481 in
                                         FStar_Syntax_Syntax.null_bv
                                           uu____9480 in
                                       (uu____9479, q) in
                                     [uu____9474] in
                                   (w', q) :: uu____9467 in
                                 (w', uu____9460)
                               else
                                 (let x =
                                    let uu____9502 = star_type' env h in
                                    FStar_Syntax_Syntax.gen_bv
                                      (Prims.strcat
                                         (bv.FStar_Syntax_Syntax.ppname).FStar_Ident.idText
                                         "__x") FStar_Pervasives_Native.None
                                      uu____9502 in
                                  (x, [(x, q)]))) binders_orig in
                    FStar_List.split uu____9393 in
                  (match uu____9378 with
                   | (bvs,binders2) ->
                       let binders3 = FStar_List.flatten binders2 in
                       let comp2 =
                         let uu____9557 =
                           let uu____9560 =
                             FStar_Syntax_Syntax.binders_of_list bvs in
                           FStar_Syntax_Util.rename_binders binders_orig
                             uu____9560 in
                         FStar_Syntax_Subst.subst_comp uu____9557 comp1 in
                       let app =
                         let uu____9564 =
                           let uu____9565 =
                             let uu____9580 =
                               FStar_List.map
                                 (fun bv  ->
                                    let uu____9595 =
                                      FStar_Syntax_Syntax.bv_to_name bv in
                                    let uu____9596 =
                                      FStar_Syntax_Syntax.as_implicit false in
                                    (uu____9595, uu____9596)) bvs in
                             (wp, uu____9580) in
                           FStar_Syntax_Syntax.Tm_app uu____9565 in
                         mk1 uu____9564 in
                       let comp3 =
                         let uu____9604 = type_of_comp comp2 in
                         let uu____9605 = is_monadic_comp comp2 in
                         trans_G env uu____9604 uu____9605 app in
                       FStar_Syntax_Util.arrow binders3 comp3))
         | FStar_Syntax_Syntax.Tm_ascribed (e,uu____9607,uu____9608) ->
             trans_F_ env e wp
         | uu____9649 -> failwith "impossible trans_F_")
and trans_G:
  env_ ->
    FStar_Syntax_Syntax.typ ->
      Prims.bool -> FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.comp
  =
  fun env  ->
    fun h  ->
      fun is_monadic1  ->
        fun wp  ->
          if is_monadic1
          then
            let uu____9654 =
              let uu____9655 = star_type' env h in
              let uu____9658 =
                let uu____9667 =
                  let uu____9672 = FStar_Syntax_Syntax.as_implicit false in
                  (wp, uu____9672) in
                [uu____9667] in
              {
                FStar_Syntax_Syntax.comp_univs =
                  [FStar_Syntax_Syntax.U_unknown];
                FStar_Syntax_Syntax.effect_name =
                  FStar_Parser_Const.effect_PURE_lid;
                FStar_Syntax_Syntax.result_typ = uu____9655;
                FStar_Syntax_Syntax.effect_args = uu____9658;
                FStar_Syntax_Syntax.flags = []
              } in
            FStar_Syntax_Syntax.mk_Comp uu____9654
          else
            (let uu____9682 = trans_F_ env h wp in
             FStar_Syntax_Syntax.mk_Total uu____9682)
let n:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  FStar_TypeChecker_Normalize.normalize
    [FStar_TypeChecker_Normalize.Beta;
    FStar_TypeChecker_Normalize.UnfoldUntil
      FStar_Syntax_Syntax.Delta_constant;
    FStar_TypeChecker_Normalize.NoDeltaSteps;
    FStar_TypeChecker_Normalize.Eager_unfolding;
    FStar_TypeChecker_Normalize.EraseUniverses]
let star_type: env -> FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ =
  fun env  ->
    fun t  -> let uu____9693 = n env.env t in star_type' env uu____9693
let star_expr:
  env ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple3
  =
  fun env  ->
    fun t  -> let uu____9708 = n env.env t in check_n env uu____9708
let trans_F:
  env ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  fun env  ->
    fun c  ->
      fun wp  ->
        let uu____9718 = n env.env c in
        let uu____9719 = n env.env wp in trans_F_ env uu____9718 uu____9719