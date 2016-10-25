
open Prims

let set_hint_correlator : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt  ->  FStar_TypeChecker_Env.env = (fun env se -> (match ((FStar_Options.reuse_hint_for ())) with
| Some (l) -> begin
(

let lid = (let _156_5 = (FStar_TypeChecker_Env.current_module env)
in (FStar_Ident.lid_add_suffix _156_5 l))
in (

let _59_17 = env
in {FStar_TypeChecker_Env.solver = _59_17.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_17.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_17.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_17.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_17.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_17.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_17.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_17.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_17.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_17.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_17.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _59_17.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _59_17.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _59_17.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _59_17.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_17.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _59_17.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _59_17.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = _59_17.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = _59_17.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _59_17.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_17.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_17.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = Some (((lid), ((Prims.parse_int "0"))))}))
end
| None -> begin
(

let lids = (FStar_Syntax_Util.lids_of_sigelt se)
in (

let lid = (match (lids) with
| [] -> begin
(let _156_8 = (FStar_TypeChecker_Env.current_module env)
in (let _156_7 = (let _156_6 = (FStar_Syntax_Syntax.next_id ())
in (FStar_All.pipe_right _156_6 FStar_Util.string_of_int))
in (FStar_Ident.lid_add_suffix _156_8 _156_7)))
end
| (l)::_59_23 -> begin
l
end)
in (

let _59_27 = env
in {FStar_TypeChecker_Env.solver = _59_27.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_27.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_27.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_27.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_27.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_27.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_27.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_27.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_27.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_27.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_27.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _59_27.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _59_27.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _59_27.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _59_27.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_27.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _59_27.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _59_27.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = _59_27.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = _59_27.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _59_27.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_27.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_27.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = Some (((lid), ((Prims.parse_int "0"))))})))
end))


let log : FStar_TypeChecker_Env.env  ->  Prims.bool = (fun env -> ((FStar_Options.log_types ()) && (not ((let _156_11 = (FStar_TypeChecker_Env.current_module env)
in (FStar_Ident.lid_equals FStar_Syntax_Const.prims_lid _156_11))))))


let tc_check_trivial_guard : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term = (fun env t k -> (

let _59_36 = (FStar_TypeChecker_TcTerm.tc_check_tot_or_gtot_term env t k)
in (match (_59_36) with
| (t, c, g) -> begin
(

let _59_37 = (FStar_ST.op_Colon_Equals t.FStar_Syntax_Syntax.tk (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)))
in (

let _59_39 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in t))
end)))


let recheck_debug : Prims.string  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun s env t -> (

let _59_44 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(let _156_24 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "Term has been %s-transformed to:\n%s\n----------\n" s _156_24))
end else begin
()
end
in (

let _59_51 = (FStar_TypeChecker_TcTerm.tc_term env t)
in (match (_59_51) with
| (t', _59_48, _59_50) -> begin
(

let _59_52 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(let _156_25 = (FStar_Syntax_Print.term_to_string t')
in (FStar_Util.print1 "Re-checked; got:\n%s\n----------\n" _156_25))
end else begin
()
end
in t)
end))))


let check_and_gen : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.tscheme = (fun env t k -> (let _156_32 = (tc_check_trivial_guard env t k)
in (FStar_TypeChecker_Util.generalize_universes env _156_32)))


let check_nogen = (fun env t k -> (

let t = (tc_check_trivial_guard env t k)
in (let _156_36 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env t)
in (([]), (_156_36)))))


let tc_tparams : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.binders * FStar_TypeChecker_Env.env * FStar_Syntax_Syntax.universes) = (fun env tps -> (

let _59_67 = (FStar_TypeChecker_TcTerm.tc_binders env tps)
in (match (_59_67) with
| (tps, env, g, us) -> begin
(

let _59_68 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in ((tps), (env), (us)))
end)))


let monad_signature : FStar_TypeChecker_Env.env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun env m s -> (

let fail = (fun _59_74 -> (match (()) with
| () -> begin
(let _156_51 = (let _156_50 = (let _156_49 = (FStar_TypeChecker_Errors.unexpected_signature_for_monad env m s)
in ((_156_49), ((FStar_Ident.range_of_lid m))))
in FStar_Syntax_Syntax.Error (_156_50))
in (Prims.raise _156_51))
end))
in (

let s = (FStar_Syntax_Subst.compress s)
in (match (s.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let bs = (FStar_Syntax_Subst.open_binders bs)
in (match (bs) with
| ((a, _59_87))::((wp, _59_83))::[] -> begin
((a), (wp.FStar_Syntax_Syntax.sort))
end
| _59_91 -> begin
(fail ())
end))
end
| _59_93 -> begin
(fail ())
end))))


let open_univ_vars : FStar_Syntax_Syntax.univ_names  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.univ_names * (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list * FStar_Syntax_Syntax.comp) = (fun uvs binders c -> (match (binders) with
| [] -> begin
(

let _59_100 = (FStar_Syntax_Subst.open_univ_vars_comp uvs c)
in (match (_59_100) with
| (uvs, c) -> begin
((uvs), ([]), (c))
end))
end
| _59_102 -> begin
(

let t' = (FStar_Syntax_Util.arrow binders c)
in (

let _59_106 = (FStar_Syntax_Subst.open_univ_vars uvs t')
in (match (_59_106) with
| (uvs, t') -> begin
(match ((let _156_58 = (FStar_Syntax_Subst.compress t')
in _156_58.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
((uvs), (binders), (c))
end
| _59_112 -> begin
(FStar_All.failwith "Impossible")
end)
end)))
end))


let rec tc_eff_decl : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.eff_decl  ->  FStar_Syntax_Syntax.eff_decl = (fun env0 ed -> (

let _59_115 = ()
in (

let _59_120 = (FStar_Syntax_Subst.open_term' ed.FStar_Syntax_Syntax.binders ed.FStar_Syntax_Syntax.signature)
in (match (_59_120) with
| (effect_params_un, signature_un, opening) -> begin
(

let _59_125 = (tc_tparams env0 effect_params_un)
in (match (_59_125) with
| (effect_params, env, _59_124) -> begin
(

let _59_129 = (FStar_TypeChecker_TcTerm.tc_trivial_guard env signature_un)
in (match (_59_129) with
| (signature, _59_128) -> begin
(

let ed = (

let _59_130 = ed
in {FStar_Syntax_Syntax.qualifiers = _59_130.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.mname = _59_130.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = _59_130.FStar_Syntax_Syntax.univs; FStar_Syntax_Syntax.binders = effect_params; FStar_Syntax_Syntax.signature = signature; FStar_Syntax_Syntax.ret_wp = _59_130.FStar_Syntax_Syntax.ret_wp; FStar_Syntax_Syntax.bind_wp = _59_130.FStar_Syntax_Syntax.bind_wp; FStar_Syntax_Syntax.if_then_else = _59_130.FStar_Syntax_Syntax.if_then_else; FStar_Syntax_Syntax.ite_wp = _59_130.FStar_Syntax_Syntax.ite_wp; FStar_Syntax_Syntax.stronger = _59_130.FStar_Syntax_Syntax.stronger; FStar_Syntax_Syntax.close_wp = _59_130.FStar_Syntax_Syntax.close_wp; FStar_Syntax_Syntax.assert_p = _59_130.FStar_Syntax_Syntax.assert_p; FStar_Syntax_Syntax.assume_p = _59_130.FStar_Syntax_Syntax.assume_p; FStar_Syntax_Syntax.null_wp = _59_130.FStar_Syntax_Syntax.null_wp; FStar_Syntax_Syntax.trivial = _59_130.FStar_Syntax_Syntax.trivial; FStar_Syntax_Syntax.repr = _59_130.FStar_Syntax_Syntax.repr; FStar_Syntax_Syntax.return_repr = _59_130.FStar_Syntax_Syntax.return_repr; FStar_Syntax_Syntax.bind_repr = _59_130.FStar_Syntax_Syntax.bind_repr; FStar_Syntax_Syntax.actions = _59_130.FStar_Syntax_Syntax.actions})
in (

let ed = (match (effect_params) with
| [] -> begin
ed
end
| _59_135 -> begin
(

let op = (fun ts -> (

let _59_138 = ()
in (

let t1 = (FStar_Syntax_Subst.subst opening (Prims.snd ts))
in (([]), (t1)))))
in (

let _59_141 = ed
in (let _156_101 = (op ed.FStar_Syntax_Syntax.ret_wp)
in (let _156_100 = (op ed.FStar_Syntax_Syntax.bind_wp)
in (let _156_99 = (op ed.FStar_Syntax_Syntax.if_then_else)
in (let _156_98 = (op ed.FStar_Syntax_Syntax.ite_wp)
in (let _156_97 = (op ed.FStar_Syntax_Syntax.stronger)
in (let _156_96 = (op ed.FStar_Syntax_Syntax.close_wp)
in (let _156_95 = (op ed.FStar_Syntax_Syntax.assert_p)
in (let _156_94 = (op ed.FStar_Syntax_Syntax.assume_p)
in (let _156_93 = (op ed.FStar_Syntax_Syntax.null_wp)
in (let _156_92 = (op ed.FStar_Syntax_Syntax.trivial)
in (let _156_91 = (let _156_82 = (op (([]), (ed.FStar_Syntax_Syntax.repr)))
in (Prims.snd _156_82))
in (let _156_90 = (op ed.FStar_Syntax_Syntax.return_repr)
in (let _156_89 = (op ed.FStar_Syntax_Syntax.bind_repr)
in (let _156_88 = (FStar_List.map (fun a -> (

let _59_144 = a
in (let _156_87 = (let _156_84 = (op (([]), (a.FStar_Syntax_Syntax.action_defn)))
in (Prims.snd _156_84))
in (let _156_86 = (let _156_85 = (op (([]), (a.FStar_Syntax_Syntax.action_typ)))
in (Prims.snd _156_85))
in {FStar_Syntax_Syntax.action_name = _59_144.FStar_Syntax_Syntax.action_name; FStar_Syntax_Syntax.action_univs = _59_144.FStar_Syntax_Syntax.action_univs; FStar_Syntax_Syntax.action_defn = _156_87; FStar_Syntax_Syntax.action_typ = _156_86})))) ed.FStar_Syntax_Syntax.actions)
in {FStar_Syntax_Syntax.qualifiers = _59_141.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.mname = _59_141.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = _59_141.FStar_Syntax_Syntax.univs; FStar_Syntax_Syntax.binders = _59_141.FStar_Syntax_Syntax.binders; FStar_Syntax_Syntax.signature = _59_141.FStar_Syntax_Syntax.signature; FStar_Syntax_Syntax.ret_wp = _156_101; FStar_Syntax_Syntax.bind_wp = _156_100; FStar_Syntax_Syntax.if_then_else = _156_99; FStar_Syntax_Syntax.ite_wp = _156_98; FStar_Syntax_Syntax.stronger = _156_97; FStar_Syntax_Syntax.close_wp = _156_96; FStar_Syntax_Syntax.assert_p = _156_95; FStar_Syntax_Syntax.assume_p = _156_94; FStar_Syntax_Syntax.null_wp = _156_93; FStar_Syntax_Syntax.trivial = _156_92; FStar_Syntax_Syntax.repr = _156_91; FStar_Syntax_Syntax.return_repr = _156_90; FStar_Syntax_Syntax.bind_repr = _156_89; FStar_Syntax_Syntax.actions = _156_88}))))))))))))))))
end)
in (

let wp_with_fresh_result_type = (fun env mname signature -> (

let fail = (fun t -> (let _156_112 = (let _156_111 = (let _156_110 = (FStar_TypeChecker_Errors.unexpected_signature_for_monad env mname t)
in ((_156_110), ((FStar_Ident.range_of_lid mname))))
in FStar_Syntax_Syntax.Error (_156_111))
in (Prims.raise _156_112)))
in (match ((let _156_113 = (FStar_Syntax_Subst.compress signature)
in _156_113.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let bs = (FStar_Syntax_Subst.open_binders bs)
in (match (bs) with
| ((a, _59_164))::((wp, _59_160))::[] -> begin
((a), (wp.FStar_Syntax_Syntax.sort))
end
| _59_168 -> begin
(fail signature)
end))
end
| _59_170 -> begin
(fail signature)
end)))
in (

let _59_173 = (wp_with_fresh_result_type env ed.FStar_Syntax_Syntax.mname ed.FStar_Syntax_Syntax.signature)
in (match (_59_173) with
| (a, wp_a) -> begin
(

let fresh_effect_signature = (fun _59_175 -> (match (()) with
| () -> begin
(

let _59_179 = (FStar_TypeChecker_TcTerm.tc_trivial_guard env signature_un)
in (match (_59_179) with
| (signature, _59_178) -> begin
(wp_with_fresh_result_type env ed.FStar_Syntax_Syntax.mname signature)
end))
end))
in (

let env = (let _156_116 = (FStar_Syntax_Syntax.new_bv None ed.FStar_Syntax_Syntax.signature)
in (FStar_TypeChecker_Env.push_bv env _156_116))
in (

let _59_181 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env0) (FStar_Options.Other ("ED"))) then begin
(let _156_122 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (let _156_121 = (FStar_Syntax_Print.binders_to_string " " ed.FStar_Syntax_Syntax.binders)
in (let _156_120 = (FStar_Syntax_Print.term_to_string ed.FStar_Syntax_Syntax.signature)
in (let _156_119 = (let _156_117 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Print.term_to_string _156_117))
in (let _156_118 = (FStar_Syntax_Print.term_to_string a.FStar_Syntax_Syntax.sort)
in (FStar_Util.print5 "Checking effect signature: %s %s : %s\n(a is %s:%s)\n" _156_122 _156_121 _156_120 _156_119 _156_118))))))
end else begin
()
end
in (

let check_and_gen' = (fun env _59_188 k -> (match (_59_188) with
| (_59_186, t) -> begin
(check_and_gen env t k)
end))
in (

let return_wp = (

let expected_k = (let _156_134 = (let _156_132 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_131 = (let _156_130 = (let _156_129 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.null_binder _156_129))
in (_156_130)::[])
in (_156_132)::_156_131))
in (let _156_133 = (FStar_Syntax_Syntax.mk_GTotal wp_a)
in (FStar_Syntax_Util.arrow _156_134 _156_133)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.ret_wp expected_k))
in (

let bind_wp = (

let _59_194 = (fresh_effect_signature ())
in (match (_59_194) with
| (b, wp_b) -> begin
(

let a_wp_b = (let _156_138 = (let _156_136 = (let _156_135 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.null_binder _156_135))
in (_156_136)::[])
in (let _156_137 = (FStar_Syntax_Syntax.mk_Total wp_b)
in (FStar_Syntax_Util.arrow _156_138 _156_137)))
in (

let expected_k = (let _156_149 = (let _156_147 = (FStar_Syntax_Syntax.null_binder FStar_TypeChecker_Common.t_range)
in (let _156_146 = (let _156_145 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_144 = (let _156_143 = (FStar_Syntax_Syntax.mk_binder b)
in (let _156_142 = (let _156_141 = (FStar_Syntax_Syntax.null_binder wp_a)
in (let _156_140 = (let _156_139 = (FStar_Syntax_Syntax.null_binder a_wp_b)
in (_156_139)::[])
in (_156_141)::_156_140))
in (_156_143)::_156_142))
in (_156_145)::_156_144))
in (_156_147)::_156_146))
in (let _156_148 = (FStar_Syntax_Syntax.mk_Total wp_b)
in (FStar_Syntax_Util.arrow _156_149 _156_148)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.bind_wp expected_k)))
end))
in (

let if_then_else = (

let p = (let _156_151 = (let _156_150 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _156_150 Prims.fst))
in (FStar_Syntax_Syntax.new_bv (Some ((FStar_Ident.range_of_lid ed.FStar_Syntax_Syntax.mname))) _156_151))
in (

let expected_k = (let _156_160 = (let _156_158 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_157 = (let _156_156 = (FStar_Syntax_Syntax.mk_binder p)
in (let _156_155 = (let _156_154 = (FStar_Syntax_Syntax.null_binder wp_a)
in (let _156_153 = (let _156_152 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_156_152)::[])
in (_156_154)::_156_153))
in (_156_156)::_156_155))
in (_156_158)::_156_157))
in (let _156_159 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _156_160 _156_159)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.if_then_else expected_k)))
in (

let ite_wp = (

let expected_k = (let _156_165 = (let _156_163 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_162 = (let _156_161 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_156_161)::[])
in (_156_163)::_156_162))
in (let _156_164 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _156_165 _156_164)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.ite_wp expected_k))
in (

let stronger = (

let _59_206 = (FStar_Syntax_Util.type_u ())
in (match (_59_206) with
| (t, _59_205) -> begin
(

let expected_k = (let _156_172 = (let _156_170 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_169 = (let _156_168 = (FStar_Syntax_Syntax.null_binder wp_a)
in (let _156_167 = (let _156_166 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_156_166)::[])
in (_156_168)::_156_167))
in (_156_170)::_156_169))
in (let _156_171 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow _156_172 _156_171)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.stronger expected_k))
end))
in (

let close_wp = (

let b = (let _156_174 = (let _156_173 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _156_173 Prims.fst))
in (FStar_Syntax_Syntax.new_bv (Some ((FStar_Ident.range_of_lid ed.FStar_Syntax_Syntax.mname))) _156_174))
in (

let b_wp_a = (let _156_178 = (let _156_176 = (let _156_175 = (FStar_Syntax_Syntax.bv_to_name b)
in (FStar_Syntax_Syntax.null_binder _156_175))
in (_156_176)::[])
in (let _156_177 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _156_178 _156_177)))
in (

let expected_k = (let _156_185 = (let _156_183 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_182 = (let _156_181 = (FStar_Syntax_Syntax.mk_binder b)
in (let _156_180 = (let _156_179 = (FStar_Syntax_Syntax.null_binder b_wp_a)
in (_156_179)::[])
in (_156_181)::_156_180))
in (_156_183)::_156_182))
in (let _156_184 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _156_185 _156_184)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.close_wp expected_k))))
in (

let assert_p = (

let expected_k = (let _156_194 = (let _156_192 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_191 = (let _156_190 = (let _156_187 = (let _156_186 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _156_186 Prims.fst))
in (FStar_Syntax_Syntax.null_binder _156_187))
in (let _156_189 = (let _156_188 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_156_188)::[])
in (_156_190)::_156_189))
in (_156_192)::_156_191))
in (let _156_193 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _156_194 _156_193)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.assert_p expected_k))
in (

let assume_p = (

let expected_k = (let _156_203 = (let _156_201 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_200 = (let _156_199 = (let _156_196 = (let _156_195 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _156_195 Prims.fst))
in (FStar_Syntax_Syntax.null_binder _156_196))
in (let _156_198 = (let _156_197 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_156_197)::[])
in (_156_199)::_156_198))
in (_156_201)::_156_200))
in (let _156_202 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _156_203 _156_202)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.assume_p expected_k))
in (

let null_wp = (

let expected_k = (let _156_206 = (let _156_204 = (FStar_Syntax_Syntax.mk_binder a)
in (_156_204)::[])
in (let _156_205 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _156_206 _156_205)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.null_wp expected_k))
in (

let trivial_wp = (

let _59_222 = (FStar_Syntax_Util.type_u ())
in (match (_59_222) with
| (t, _59_221) -> begin
(

let expected_k = (let _156_211 = (let _156_209 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_208 = (let _156_207 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_156_207)::[])
in (_156_209)::_156_208))
in (let _156_210 = (FStar_Syntax_Syntax.mk_GTotal t)
in (FStar_Syntax_Util.arrow _156_211 _156_210)))
in (check_and_gen' env ed.FStar_Syntax_Syntax.trivial expected_k))
end))
in (

let _59_366 = (match ((let _156_212 = (FStar_Syntax_Subst.compress ed.FStar_Syntax_Syntax.repr)
in _156_212.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
((ed.FStar_Syntax_Syntax.repr), (ed.FStar_Syntax_Syntax.bind_repr), (ed.FStar_Syntax_Syntax.return_repr), (ed.FStar_Syntax_Syntax.actions))
end
| _59_227 -> begin
(

let repr = (

let _59_231 = (FStar_Syntax_Util.type_u ())
in (match (_59_231) with
| (t, _59_230) -> begin
(

let expected_k = (let _156_217 = (let _156_215 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_214 = (let _156_213 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_156_213)::[])
in (_156_215)::_156_214))
in (let _156_216 = (FStar_Syntax_Syntax.mk_GTotal t)
in (FStar_Syntax_Util.arrow _156_217 _156_216)))
in (tc_check_trivial_guard env ed.FStar_Syntax_Syntax.repr expected_k))
end))
in (

let mk_repr' = (fun t wp -> (

let repr = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.EraseUniverses)::(FStar_TypeChecker_Normalize.AllowUnboundUniverses)::[]) env repr)
in (let _156_227 = (let _156_226 = (let _156_225 = (let _156_224 = (FStar_Syntax_Syntax.as_arg t)
in (let _156_223 = (let _156_222 = (FStar_Syntax_Syntax.as_arg wp)
in (_156_222)::[])
in (_156_224)::_156_223))
in ((repr), (_156_225)))
in FStar_Syntax_Syntax.Tm_app (_156_226))
in (FStar_Syntax_Syntax.mk _156_227 None FStar_Range.dummyRange))))
in (

let mk_repr = (fun a wp -> (let _156_232 = (FStar_Syntax_Syntax.bv_to_name a)
in (mk_repr' _156_232 wp)))
in (

let destruct_repr = (fun t -> (match ((let _156_235 = (FStar_Syntax_Subst.compress t)
in _156_235.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_app (_59_244, ((t, _59_251))::((wp, _59_247))::[]) -> begin
((t), (wp))
end
| _59_257 -> begin
(FStar_All.failwith "Unexpected repr type")
end))
in (

let bind_repr = (

let r = (let _156_236 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.range_0 FStar_Syntax_Syntax.Delta_constant None)
in (FStar_All.pipe_right _156_236 FStar_Syntax_Syntax.fv_to_tm))
in (

let _59_261 = (fresh_effect_signature ())
in (match (_59_261) with
| (b, wp_b) -> begin
(

let a_wp_b = (let _156_240 = (let _156_238 = (let _156_237 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.null_binder _156_237))
in (_156_238)::[])
in (let _156_239 = (FStar_Syntax_Syntax.mk_Total wp_b)
in (FStar_Syntax_Util.arrow _156_240 _156_239)))
in (

let wp_f = (FStar_Syntax_Syntax.gen_bv "wp_f" None wp_a)
in (

let wp_g = (FStar_Syntax_Syntax.gen_bv "wp_g" None a_wp_b)
in (

let x_a = (let _156_241 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.gen_bv "x_a" None _156_241))
in (

let wp_g_x = (let _156_245 = (FStar_Syntax_Syntax.bv_to_name wp_g)
in (let _156_244 = (let _156_243 = (let _156_242 = (FStar_Syntax_Syntax.bv_to_name x_a)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _156_242))
in (_156_243)::[])
in (FStar_Syntax_Syntax.mk_Tm_app _156_245 _156_244 None FStar_Range.dummyRange)))
in (

let res = (

let wp = (let _156_257 = (let _156_246 = (FStar_TypeChecker_Env.inst_tscheme bind_wp)
in (FStar_All.pipe_right _156_246 Prims.snd))
in (let _156_256 = (let _156_255 = (let _156_254 = (let _156_253 = (FStar_Syntax_Syntax.bv_to_name a)
in (let _156_252 = (let _156_251 = (FStar_Syntax_Syntax.bv_to_name b)
in (let _156_250 = (let _156_249 = (FStar_Syntax_Syntax.bv_to_name wp_f)
in (let _156_248 = (let _156_247 = (FStar_Syntax_Syntax.bv_to_name wp_g)
in (_156_247)::[])
in (_156_249)::_156_248))
in (_156_251)::_156_250))
in (_156_253)::_156_252))
in (r)::_156_254)
in (FStar_List.map FStar_Syntax_Syntax.as_arg _156_255))
in (FStar_Syntax_Syntax.mk_Tm_app _156_257 _156_256 None FStar_Range.dummyRange)))
in (mk_repr b wp))
in (

let expected_k = (let _156_277 = (let _156_275 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_274 = (let _156_273 = (FStar_Syntax_Syntax.mk_binder b)
in (let _156_272 = (let _156_271 = (FStar_Syntax_Syntax.mk_binder wp_f)
in (let _156_270 = (let _156_269 = (let _156_259 = (let _156_258 = (FStar_Syntax_Syntax.bv_to_name wp_f)
in (mk_repr a _156_258))
in (FStar_Syntax_Syntax.null_binder _156_259))
in (let _156_268 = (let _156_267 = (FStar_Syntax_Syntax.mk_binder wp_g)
in (let _156_266 = (let _156_265 = (let _156_264 = (let _156_263 = (let _156_260 = (FStar_Syntax_Syntax.mk_binder x_a)
in (_156_260)::[])
in (let _156_262 = (let _156_261 = (mk_repr b wp_g_x)
in (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Total _156_261))
in (FStar_Syntax_Util.arrow _156_263 _156_262)))
in (FStar_Syntax_Syntax.null_binder _156_264))
in (_156_265)::[])
in (_156_267)::_156_266))
in (_156_269)::_156_268))
in (_156_271)::_156_270))
in (_156_273)::_156_272))
in (_156_275)::_156_274))
in (let _156_276 = (FStar_Syntax_Syntax.mk_Total res)
in (FStar_Syntax_Util.arrow _156_277 _156_276)))
in (

let _59_275 = (FStar_TypeChecker_TcTerm.tc_tot_or_gtot_term env expected_k)
in (match (_59_275) with
| (expected_k, _59_272, _59_274) -> begin
(

let env = (FStar_TypeChecker_Env.set_range env (Prims.snd ed.FStar_Syntax_Syntax.bind_repr).FStar_Syntax_Syntax.pos)
in (

let env = (

let _59_277 = env
in {FStar_TypeChecker_Env.solver = _59_277.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_277.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_277.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_277.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_277.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_277.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_277.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_277.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_277.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_277.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_277.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _59_277.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _59_277.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _59_277.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _59_277.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_277.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _59_277.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _59_277.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = true; FStar_TypeChecker_Env.lax_universes = _59_277.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _59_277.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_277.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_277.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = _59_277.FStar_TypeChecker_Env.qname_and_index})
in (

let br = (check_and_gen' env ed.FStar_Syntax_Syntax.bind_repr expected_k)
in br)))
end)))))))))
end)))
in (

let return_repr = (

let x_a = (let _156_278 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.gen_bv "x_a" None _156_278))
in (

let res = (

let wp = (let _156_285 = (let _156_279 = (FStar_TypeChecker_Env.inst_tscheme return_wp)
in (FStar_All.pipe_right _156_279 Prims.snd))
in (let _156_284 = (let _156_283 = (let _156_282 = (FStar_Syntax_Syntax.bv_to_name a)
in (let _156_281 = (let _156_280 = (FStar_Syntax_Syntax.bv_to_name x_a)
in (_156_280)::[])
in (_156_282)::_156_281))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _156_283))
in (FStar_Syntax_Syntax.mk_Tm_app _156_285 _156_284 None FStar_Range.dummyRange)))
in (mk_repr a wp))
in (

let expected_k = (let _156_290 = (let _156_288 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_287 = (let _156_286 = (FStar_Syntax_Syntax.mk_binder x_a)
in (_156_286)::[])
in (_156_288)::_156_287))
in (let _156_289 = (FStar_Syntax_Syntax.mk_Total res)
in (FStar_Syntax_Util.arrow _156_290 _156_289)))
in (

let _59_291 = (FStar_TypeChecker_TcTerm.tc_tot_or_gtot_term env expected_k)
in (match (_59_291) with
| (expected_k, _59_288, _59_290) -> begin
(

let env = (FStar_TypeChecker_Env.set_range env (Prims.snd ed.FStar_Syntax_Syntax.return_repr).FStar_Syntax_Syntax.pos)
in (

let _59_295 = (check_and_gen' env ed.FStar_Syntax_Syntax.return_repr expected_k)
in (match (_59_295) with
| (univs, repr) -> begin
(match (univs) with
| [] -> begin
(([]), (repr))
end
| _59_298 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected universe-polymorphic return for effect"), (repr.FStar_Syntax_Syntax.pos)))))
end)
end)))
end)))))
in (

let actions = (

let check_action = (fun act -> (

let _59_306 = (FStar_TypeChecker_TcTerm.tc_tot_or_gtot_term env act.FStar_Syntax_Syntax.action_typ)
in (match (_59_306) with
| (act_typ, _59_304, g_t) -> begin
(

let env' = (FStar_TypeChecker_Env.set_expected_typ env act_typ)
in (

let _59_308 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(let _156_294 = (FStar_Syntax_Print.term_to_string act.FStar_Syntax_Syntax.action_defn)
in (let _156_293 = (FStar_Syntax_Print.term_to_string act_typ)
in (FStar_Util.print3 "Checking action %s:\n[definition]: %s\n[cps\'d type]: %s\n" (FStar_Ident.text_of_lid act.FStar_Syntax_Syntax.action_name) _156_294 _156_293)))
end else begin
()
end
in (

let _59_314 = (FStar_TypeChecker_TcTerm.tc_tot_or_gtot_term env' act.FStar_Syntax_Syntax.action_defn)
in (match (_59_314) with
| (act_defn, _59_312, g_a) -> begin
(

let act_defn = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::[]) env act_defn)
in (

let act_typ = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::(FStar_TypeChecker_Normalize.Eager_unfolding)::(FStar_TypeChecker_Normalize.Beta)::[]) env act_typ)
in (

let _59_337 = (

let act_typ = (FStar_Syntax_Subst.compress act_typ)
in (match (act_typ.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let _59_325 = (FStar_Syntax_Subst.open_comp bs c)
in (match (_59_325) with
| (bs, _59_324) -> begin
(

let res = (mk_repr' FStar_Syntax_Syntax.tun FStar_Syntax_Syntax.tun)
in (

let k = (let _156_295 = (FStar_Syntax_Syntax.mk_Total res)
in (FStar_Syntax_Util.arrow bs _156_295))
in (

let _59_332 = (FStar_TypeChecker_TcTerm.tc_tot_or_gtot_term env k)
in (match (_59_332) with
| (k, _59_330, g) -> begin
((k), (g))
end))))
end))
end
| _59_334 -> begin
(let _156_300 = (let _156_299 = (let _156_298 = (let _156_297 = (FStar_Syntax_Print.term_to_string act_typ)
in (let _156_296 = (FStar_Syntax_Print.tag_of_term act_typ)
in (FStar_Util.format2 "Actions must have function types (not: %s, a.k.a. %s)" _156_297 _156_296)))
in ((_156_298), (act_defn.FStar_Syntax_Syntax.pos)))
in FStar_Syntax_Syntax.Error (_156_299))
in (Prims.raise _156_300))
end))
in (match (_59_337) with
| (expected_k, g_k) -> begin
(

let g = (FStar_TypeChecker_Rel.teq env act_typ expected_k)
in (

let _59_339 = (let _156_303 = (let _156_302 = (let _156_301 = (FStar_TypeChecker_Rel.conj_guard g_t g)
in (FStar_TypeChecker_Rel.conj_guard g_k _156_301))
in (FStar_TypeChecker_Rel.conj_guard g_a _156_302))
in (FStar_TypeChecker_Rel.force_trivial_guard env _156_303))
in (

let act_typ = (match ((let _156_304 = (FStar_Syntax_Subst.compress expected_k)
in _156_304.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let _59_347 = (FStar_Syntax_Subst.open_comp bs c)
in (match (_59_347) with
| (bs, c) -> begin
(

let _59_350 = (destruct_repr (FStar_Syntax_Util.comp_result c))
in (match (_59_350) with
| (a, wp) -> begin
(

let c = (let _156_308 = (let _156_305 = (env.FStar_TypeChecker_Env.universe_of env a)
in (_156_305)::[])
in (let _156_307 = (let _156_306 = (FStar_Syntax_Syntax.as_arg wp)
in (_156_306)::[])
in {FStar_Syntax_Syntax.comp_univs = _156_308; FStar_Syntax_Syntax.effect_name = ed.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.result_typ = a; FStar_Syntax_Syntax.effect_args = _156_307; FStar_Syntax_Syntax.flags = []}))
in (let _156_309 = (FStar_Syntax_Syntax.mk_Comp c)
in (FStar_Syntax_Util.arrow bs _156_309)))
end))
end))
end
| _59_353 -> begin
(FStar_All.failwith "")
end)
in (

let _59_357 = (FStar_TypeChecker_Util.generalize_universes env act_defn)
in (match (_59_357) with
| (univs, act_defn) -> begin
(

let act_typ = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env act_typ)
in (

let _59_359 = act
in {FStar_Syntax_Syntax.action_name = _59_359.FStar_Syntax_Syntax.action_name; FStar_Syntax_Syntax.action_univs = univs; FStar_Syntax_Syntax.action_defn = act_defn; FStar_Syntax_Syntax.action_typ = act_typ}))
end)))))
end))))
end))))
end)))
in (FStar_All.pipe_right ed.FStar_Syntax_Syntax.actions (FStar_List.map check_action)))
in ((repr), (bind_repr), (return_repr), (actions)))))))))
end)
in (match (_59_366) with
| (repr, bind_repr, return_repr, actions) -> begin
(

let t = (let _156_310 = (FStar_Syntax_Syntax.mk_Total ed.FStar_Syntax_Syntax.signature)
in (FStar_Syntax_Util.arrow ed.FStar_Syntax_Syntax.binders _156_310))
in (

let _59_370 = (FStar_TypeChecker_Util.generalize_universes env0 t)
in (match (_59_370) with
| (univs, t) -> begin
(

let signature = (match ((let _156_312 = (let _156_311 = (FStar_Syntax_Subst.compress t)
in _156_311.FStar_Syntax_Syntax.n)
in ((effect_params), (_156_312)))) with
| ([], _59_373) -> begin
t
end
| (_59_376, FStar_Syntax_Syntax.Tm_arrow (_59_378, c)) -> begin
(FStar_Syntax_Util.comp_result c)
end
| _59_384 -> begin
(FStar_All.failwith "Impossible")
end)
in (

let close = (fun n ts -> (

let ts = (let _156_317 = (FStar_Syntax_Subst.close_tscheme effect_params ts)
in (FStar_Syntax_Subst.close_univ_vars_tscheme univs _156_317))
in (

let _59_390 = if (((n > (Prims.parse_int "0")) && (not ((FStar_Syntax_Util.is_unknown (Prims.snd ts))))) && ((FStar_List.length (Prims.fst ts)) <> n)) then begin
(let _156_320 = (let _156_319 = (FStar_Util.string_of_int n)
in (let _156_318 = (FStar_Syntax_Print.tscheme_to_string ts)
in (FStar_Util.format2 "The effect combinator is not universe-polymorphic enough (n=%s) (%s)" _156_319 _156_318)))
in (FStar_All.failwith _156_320))
end else begin
()
end
in ts)))
in (

let close_action = (fun act -> (

let _59_396 = (close (~- ((Prims.parse_int "1"))) ((act.FStar_Syntax_Syntax.action_univs), (act.FStar_Syntax_Syntax.action_defn)))
in (match (_59_396) with
| (univs, defn) -> begin
(

let _59_399 = (close (~- ((Prims.parse_int "1"))) ((act.FStar_Syntax_Syntax.action_univs), (act.FStar_Syntax_Syntax.action_typ)))
in (match (_59_399) with
| (univs', typ) -> begin
(

let _59_400 = ()
in (

let _59_402 = act
in {FStar_Syntax_Syntax.action_name = _59_402.FStar_Syntax_Syntax.action_name; FStar_Syntax_Syntax.action_univs = univs; FStar_Syntax_Syntax.action_defn = defn; FStar_Syntax_Syntax.action_typ = typ}))
end))
end)))
in (

let _59_404 = ()
in (

let ed = (

let _59_406 = ed
in (let _156_337 = (close (Prims.parse_int "0") return_wp)
in (let _156_336 = (close (Prims.parse_int "1") bind_wp)
in (let _156_335 = (close (Prims.parse_int "0") if_then_else)
in (let _156_334 = (close (Prims.parse_int "0") ite_wp)
in (let _156_333 = (close (Prims.parse_int "0") stronger)
in (let _156_332 = (close (Prims.parse_int "1") close_wp)
in (let _156_331 = (close (Prims.parse_int "0") assert_p)
in (let _156_330 = (close (Prims.parse_int "0") assume_p)
in (let _156_329 = (close (Prims.parse_int "0") null_wp)
in (let _156_328 = (close (Prims.parse_int "0") trivial_wp)
in (let _156_327 = (let _156_323 = (close (Prims.parse_int "0") (([]), (repr)))
in (Prims.snd _156_323))
in (let _156_326 = (close (Prims.parse_int "0") return_repr)
in (let _156_325 = (close (Prims.parse_int "1") bind_repr)
in (let _156_324 = (FStar_List.map close_action actions)
in {FStar_Syntax_Syntax.qualifiers = _59_406.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.mname = _59_406.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = univs; FStar_Syntax_Syntax.binders = effect_params; FStar_Syntax_Syntax.signature = signature; FStar_Syntax_Syntax.ret_wp = _156_337; FStar_Syntax_Syntax.bind_wp = _156_336; FStar_Syntax_Syntax.if_then_else = _156_335; FStar_Syntax_Syntax.ite_wp = _156_334; FStar_Syntax_Syntax.stronger = _156_333; FStar_Syntax_Syntax.close_wp = _156_332; FStar_Syntax_Syntax.assert_p = _156_331; FStar_Syntax_Syntax.assume_p = _156_330; FStar_Syntax_Syntax.null_wp = _156_329; FStar_Syntax_Syntax.trivial = _156_328; FStar_Syntax_Syntax.repr = _156_327; FStar_Syntax_Syntax.return_repr = _156_326; FStar_Syntax_Syntax.bind_repr = _156_325; FStar_Syntax_Syntax.actions = _156_324})))))))))))))))
in (

let _59_409 = if ((FStar_TypeChecker_Env.debug env FStar_Options.Low) || (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("ED")))) then begin
(let _156_338 = (FStar_Syntax_Print.eff_decl_to_string false ed)
in (FStar_Util.print_string _156_338))
end else begin
()
end
in ed))))))
end)))
end))))))))))))))))
end)))))
end))
end))
end))))
and cps_and_elaborate : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.eff_decl  ->  (FStar_Syntax_Syntax.sigelt Prims.list * FStar_Syntax_Syntax.eff_decl) = (fun env ed -> (

let _59_415 = (FStar_Syntax_Subst.open_term ed.FStar_Syntax_Syntax.binders ed.FStar_Syntax_Syntax.signature)
in (match (_59_415) with
| (effect_binders_un, signature_un) -> begin
(

let _59_420 = (tc_tparams env effect_binders_un)
in (match (_59_420) with
| (effect_binders, env, _59_419) -> begin
(

let _59_424 = (FStar_TypeChecker_TcTerm.tc_trivial_guard env signature_un)
in (match (_59_424) with
| (signature, _59_423) -> begin
(

let effect_binders = (FStar_List.map (fun _59_427 -> (match (_59_427) with
| (bv, qual) -> begin
(let _156_343 = (

let _59_428 = bv
in (let _156_342 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.EraseUniverses)::[]) env bv.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _59_428.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_428.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _156_342}))
in ((_156_343), (qual)))
end)) effect_binders)
in (

let _59_443 = (match ((let _156_344 = (FStar_Syntax_Subst.compress signature_un)
in _156_344.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (((a, _59_433))::[], effect_marker) -> begin
((a), (effect_marker))
end
| _59_440 -> begin
(FStar_All.failwith "bad shape for effect-for-free signature")
end)
in (match (_59_443) with
| (a, effect_marker) -> begin
(

let open_and_check = (fun t -> (

let subst = (FStar_Syntax_Subst.opening_of_binders effect_binders)
in (

let t = (FStar_Syntax_Subst.subst subst t)
in (

let _59_452 = (FStar_TypeChecker_TcTerm.tc_term env t)
in (match (_59_452) with
| (t, comp, _59_451) -> begin
((t), (comp))
end)))))
in (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None signature.FStar_Syntax_Syntax.pos))
in (

let _59_457 = (open_and_check ed.FStar_Syntax_Syntax.repr)
in (match (_59_457) with
| (repr, _comp) -> begin
(

let _59_458 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(let _156_349 = (FStar_Syntax_Print.term_to_string repr)
in (FStar_Util.print1 "Representation is: %s\n" _156_349))
end else begin
()
end
in (

let dmff_env = (FStar_TypeChecker_DMFF.empty env (FStar_TypeChecker_TcTerm.tc_constant FStar_Range.dummyRange))
in (

let wp_type = (FStar_TypeChecker_DMFF.star_type dmff_env repr)
in (

let wp_type = (recheck_debug "*" env wp_type)
in (

let wp_a = (let _156_356 = (let _156_355 = (let _156_354 = (let _156_353 = (let _156_352 = (let _156_351 = (FStar_Syntax_Syntax.bv_to_name a)
in (let _156_350 = (FStar_Syntax_Syntax.as_implicit false)
in ((_156_351), (_156_350))))
in (_156_352)::[])
in ((wp_type), (_156_353)))
in FStar_Syntax_Syntax.Tm_app (_156_354))
in (mk _156_355))
in (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env _156_356))
in (

let effect_signature = (

let binders = (let _156_361 = (let _156_357 = (FStar_Syntax_Syntax.as_implicit false)
in ((a), (_156_357)))
in (let _156_360 = (let _156_359 = (let _156_358 = (FStar_Syntax_Syntax.gen_bv "dijkstra_wp" None wp_a)
in (FStar_All.pipe_right _156_358 FStar_Syntax_Syntax.mk_binder))
in (_156_359)::[])
in (_156_361)::_156_360))
in (

let binders = (FStar_Syntax_Subst.close_binders binders)
in (mk (FStar_Syntax_Syntax.Tm_arrow (((binders), (effect_marker)))))))
in (

let effect_signature = (recheck_debug "turned into the effect signature" env effect_signature)
in (

let sigelts = (FStar_ST.alloc [])
in (

let mk_lid = (fun name -> (FStar_Ident.lid_of_path (FStar_Ident.path_of_text (Prims.strcat (FStar_Ident.text_of_lid ed.FStar_Syntax_Syntax.mname) (Prims.strcat "_" name))) FStar_Range.dummyRange))
in (

let elaborate_and_star = (fun dmff_env item -> (

let _59_476 = item
in (match (_59_476) with
| (u_item, item) -> begin
(

let _59_479 = (open_and_check item)
in (match (_59_479) with
| (item, item_comp) -> begin
(

let _59_480 = if (not ((FStar_Syntax_Util.is_total_lcomp item_comp))) then begin
(Prims.raise (FStar_Syntax_Syntax.Err ("Computation for [item] is not total!")))
end else begin
()
end
in (

let _59_485 = (FStar_TypeChecker_DMFF.star_expr dmff_env item)
in (match (_59_485) with
| (item_t, item_wp, item_elab) -> begin
(

let item_wp = (recheck_debug "*" env item_wp)
in (

let item_elab = (recheck_debug "_" env item_elab)
in ((dmff_env), (item_t), (item_wp), (item_elab))))
end)))
end))
end)))
in (

let _59_493 = (elaborate_and_star dmff_env ed.FStar_Syntax_Syntax.bind_repr)
in (match (_59_493) with
| (dmff_env, _59_490, bind_wp, bind_elab) -> begin
(

let _59_499 = (elaborate_and_star dmff_env ed.FStar_Syntax_Syntax.return_repr)
in (match (_59_499) with
| (dmff_env, _59_496, return_wp, return_elab) -> begin
(

let return_wp = (match ((let _156_368 = (FStar_Syntax_Subst.compress return_wp)
in _156_368.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_abs ((b1)::(b2)::bs, body, what) -> begin
(let _156_369 = (FStar_Syntax_Util.abs bs body what)
in (FStar_Syntax_Util.abs ((b1)::(b2)::[]) _156_369 (Some (FStar_Util.Inr (FStar_Syntax_Const.effect_GTot_lid)))))
end
| _59_510 -> begin
(FStar_All.failwith "unexpected shape for return")
end)
in (

let bind_wp = (match ((let _156_370 = (FStar_Syntax_Subst.compress bind_wp)
in _156_370.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_abs (binders, body, what) -> begin
(

let r = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.range_lid (FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "1"))) None)
in (let _156_374 = (let _156_373 = (let _156_372 = (let _156_371 = (mk (FStar_Syntax_Syntax.Tm_fvar (r)))
in (FStar_Syntax_Syntax.null_binder _156_371))
in (_156_372)::[])
in (FStar_List.append _156_373 binders))
in (FStar_Syntax_Util.abs _156_374 body what)))
end
| _59_519 -> begin
(FStar_All.failwith "unexpected shape for bind")
end)
in (

let apply_close = (fun t -> if ((FStar_List.length effect_binders) = (Prims.parse_int "0")) then begin
t
end else begin
(let _156_381 = (let _156_380 = (let _156_379 = (let _156_378 = (let _156_377 = (FStar_Syntax_Util.args_of_binders effect_binders)
in (Prims.snd _156_377))
in ((t), (_156_378)))
in FStar_Syntax_Syntax.Tm_app (_156_379))
in (mk _156_380))
in (FStar_Syntax_Subst.close effect_binders _156_381))
end)
in (

let register = (fun name item -> (

let _59_528 = (let _156_387 = (mk_lid name)
in (let _156_386 = (FStar_Syntax_Util.abs effect_binders item None)
in (FStar_TypeChecker_Util.mk_toplevel_definition env _156_387 _156_386)))
in (match (_59_528) with
| (sigelt, fv) -> begin
(

let _59_529 = (let _156_389 = (let _156_388 = (FStar_ST.read sigelts)
in (sigelt)::_156_388)
in (FStar_ST.op_Colon_Equals sigelts _156_389))
in fv)
end)))
in (

let return_wp = (register "return_wp" return_wp)
in (

let return_elab = (register "return_elab" return_elab)
in (

let bind_wp = (register "bind_wp" bind_wp)
in (

let _59_534 = (let _156_391 = (let _156_390 = (FStar_ST.read sigelts)
in (FStar_Syntax_Syntax.Sig_pragma (((FStar_Syntax_Syntax.SetOptions ("--admit_smt_queries true")), (FStar_Range.dummyRange))))::_156_390)
in (FStar_ST.op_Colon_Equals sigelts _156_391))
in (

let bind_elab = (register "bind_elab" bind_elab)
in (

let _59_537 = (let _156_393 = (let _156_392 = (FStar_ST.read sigelts)
in (FStar_Syntax_Syntax.Sig_pragma (((FStar_Syntax_Syntax.SetOptions ("--admit_smt_queries false")), (FStar_Range.dummyRange))))::_156_392)
in (FStar_ST.op_Colon_Equals sigelts _156_393))
in (

let _59_556 = (FStar_List.fold_left (fun _59_541 action -> (match (_59_541) with
| (dmff_env, actions) -> begin
(

let _59_547 = (elaborate_and_star dmff_env ((action.FStar_Syntax_Syntax.action_univs), (action.FStar_Syntax_Syntax.action_defn)))
in (match (_59_547) with
| (dmff_env, action_t, action_wp, action_elab) -> begin
(

let name = action.FStar_Syntax_Syntax.action_name.FStar_Ident.ident.FStar_Ident.idText
in (

let action_typ_with_wp = (FStar_TypeChecker_DMFF.trans_F dmff_env action_t action_wp)
in (

let action_elab = (register (Prims.strcat name "_elab") action_elab)
in (

let action_typ_with_wp = (register (Prims.strcat name "_complete_type") action_typ_with_wp)
in (let _156_399 = (let _156_398 = (

let _59_552 = action
in (let _156_397 = (apply_close action_elab)
in (let _156_396 = (apply_close action_typ_with_wp)
in {FStar_Syntax_Syntax.action_name = _59_552.FStar_Syntax_Syntax.action_name; FStar_Syntax_Syntax.action_univs = _59_552.FStar_Syntax_Syntax.action_univs; FStar_Syntax_Syntax.action_defn = _156_397; FStar_Syntax_Syntax.action_typ = _156_396})))
in (_156_398)::actions)
in ((dmff_env), (_156_399)))))))
end))
end)) ((dmff_env), ([])) ed.FStar_Syntax_Syntax.actions)
in (match (_59_556) with
| (dmff_env, actions) -> begin
(

let actions = (FStar_List.rev actions)
in (

let repr = (

let wp = (FStar_Syntax_Syntax.gen_bv "wp_a" None wp_a)
in (

let binders = (let _156_402 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_401 = (let _156_400 = (FStar_Syntax_Syntax.mk_binder wp)
in (_156_400)::[])
in (_156_402)::_156_401))
in (let _156_411 = (let _156_410 = (let _156_408 = (let _156_407 = (let _156_406 = (let _156_405 = (let _156_404 = (FStar_Syntax_Syntax.bv_to_name a)
in (let _156_403 = (FStar_Syntax_Syntax.as_implicit false)
in ((_156_404), (_156_403))))
in (_156_405)::[])
in ((repr), (_156_406)))
in FStar_Syntax_Syntax.Tm_app (_156_407))
in (mk _156_408))
in (let _156_409 = (FStar_Syntax_Syntax.bv_to_name wp)
in (FStar_TypeChecker_DMFF.trans_F dmff_env _156_410 _156_409)))
in (FStar_Syntax_Util.abs binders _156_411 None))))
in (

let repr = (recheck_debug "FC" env repr)
in (

let repr = (register "repr" repr)
in (

let _59_588 = (match ((let _156_412 = (FStar_Syntax_Subst.compress wp_type)
in _156_412.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_abs (effect_param, arrow, _59_566) -> begin
(

let _59_571 = (FStar_Syntax_Subst.open_term effect_param arrow)
in (match (_59_571) with
| (effect_param, arrow) -> begin
(match ((let _156_413 = (FStar_Syntax_Subst.compress arrow)
in _156_413.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (wp_binders, c) -> begin
(

let _59_578 = (FStar_Syntax_Subst.open_comp wp_binders c)
in (match (_59_578) with
| (wp_binders, c) -> begin
(

let _59_581 = (FStar_Util.prefix wp_binders)
in (match (_59_581) with
| (pre_args, post) -> begin
(let _156_415 = (FStar_Syntax_Util.arrow pre_args c)
in (let _156_414 = (FStar_Syntax_Util.abs effect_param (Prims.fst post).FStar_Syntax_Syntax.sort None)
in ((_156_415), (_156_414))))
end))
end))
end
| _59_583 -> begin
(let _156_417 = (let _156_416 = (FStar_Syntax_Print.term_to_string arrow)
in (FStar_Util.format1 "Impossible: pre/post arrow %s" _156_416))
in (FStar_All.failwith _156_417))
end)
end))
end
| _59_585 -> begin
(let _156_419 = (let _156_418 = (FStar_Syntax_Print.term_to_string wp_type)
in (FStar_Util.format1 "Impossible: pre/post abs %s" _156_418))
in (FStar_All.failwith _156_419))
end)
in (match (_59_588) with
| (pre, post) -> begin
(

let _59_589 = (let _156_420 = (register "pre" pre)
in (Prims.ignore _156_420))
in (

let _59_591 = (let _156_421 = (register "post" post)
in (Prims.ignore _156_421))
in (

let _59_593 = (let _156_422 = (register "wp" wp_type)
in (Prims.ignore _156_422))
in (

let ed = (

let _59_595 = ed
in (let _156_433 = (FStar_Syntax_Subst.close_binders effect_binders)
in (let _156_432 = (FStar_Syntax_Subst.close effect_binders effect_signature)
in (let _156_431 = (let _156_423 = (apply_close return_wp)
in (([]), (_156_423)))
in (let _156_430 = (let _156_424 = (apply_close bind_wp)
in (([]), (_156_424)))
in (let _156_429 = (apply_close repr)
in (let _156_428 = (let _156_425 = (apply_close return_elab)
in (([]), (_156_425)))
in (let _156_427 = (let _156_426 = (apply_close bind_elab)
in (([]), (_156_426)))
in {FStar_Syntax_Syntax.qualifiers = _59_595.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.mname = _59_595.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = _59_595.FStar_Syntax_Syntax.univs; FStar_Syntax_Syntax.binders = _156_433; FStar_Syntax_Syntax.signature = _156_432; FStar_Syntax_Syntax.ret_wp = _156_431; FStar_Syntax_Syntax.bind_wp = _156_430; FStar_Syntax_Syntax.if_then_else = _59_595.FStar_Syntax_Syntax.if_then_else; FStar_Syntax_Syntax.ite_wp = _59_595.FStar_Syntax_Syntax.ite_wp; FStar_Syntax_Syntax.stronger = _59_595.FStar_Syntax_Syntax.stronger; FStar_Syntax_Syntax.close_wp = _59_595.FStar_Syntax_Syntax.close_wp; FStar_Syntax_Syntax.assert_p = _59_595.FStar_Syntax_Syntax.assert_p; FStar_Syntax_Syntax.assume_p = _59_595.FStar_Syntax_Syntax.assume_p; FStar_Syntax_Syntax.null_wp = _59_595.FStar_Syntax_Syntax.null_wp; FStar_Syntax_Syntax.trivial = _59_595.FStar_Syntax_Syntax.trivial; FStar_Syntax_Syntax.repr = _156_429; FStar_Syntax_Syntax.return_repr = _156_428; FStar_Syntax_Syntax.bind_repr = _156_427; FStar_Syntax_Syntax.actions = actions}))))))))
in (

let _59_600 = (FStar_TypeChecker_DMFF.gen_wps_for_free env effect_binders a wp_a ed)
in (match (_59_600) with
| (sigelts', ed) -> begin
(

let _59_601 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(let _156_434 = (FStar_Syntax_Print.eff_decl_to_string true ed)
in (FStar_Util.print_string _156_434))
end else begin
()
end
in (let _156_437 = (let _156_436 = (let _156_435 = (FStar_ST.read sigelts)
in (FStar_List.rev _156_435))
in (FStar_List.append _156_436 sigelts'))
in ((_156_437), (ed))))
end))))))
end))))))
end))))))))))))
end))
end))))))))))))
end))))
end)))
end))
end))
end)))
and tc_lex_t : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.sigelt = (fun env ses quals lids -> (

let _59_607 = ()
in (

let _59_615 = ()
in (match (ses) with
| (FStar_Syntax_Syntax.Sig_inductive_typ (lex_t, [], [], t, _59_644, _59_646, [], r))::(FStar_Syntax_Syntax.Sig_datacon (lex_top, [], _t_top, _lex_t_top, _156_442, [], _59_635, r1))::(FStar_Syntax_Syntax.Sig_datacon (lex_cons, [], _t_cons, _lex_t_cons, _156_443, [], _59_624, r2))::[] when (((_156_442 = (Prims.parse_int "0")) && (_156_443 = (Prims.parse_int "0"))) && (((FStar_Ident.lid_equals lex_t FStar_Syntax_Const.lex_t_lid) && (FStar_Ident.lid_equals lex_top FStar_Syntax_Const.lextop_lid)) && (FStar_Ident.lid_equals lex_cons FStar_Syntax_Const.lexcons_lid))) -> begin
(

let u = (FStar_Syntax_Syntax.new_univ_name (Some (r)))
in (

let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_name (u))) None r)
in (

let t = (FStar_Syntax_Subst.close_univ_vars ((u)::[]) t)
in (

let tc = FStar_Syntax_Syntax.Sig_inductive_typ (((lex_t), ((u)::[]), ([]), (t), ([]), ((FStar_Syntax_Const.lextop_lid)::(FStar_Syntax_Const.lexcons_lid)::[]), ([]), (r)))
in (

let utop = (FStar_Syntax_Syntax.new_univ_name (Some (r1)))
in (

let lex_top_t = (let _156_447 = (let _156_446 = (let _156_445 = (let _156_444 = (FStar_Ident.set_lid_range FStar_Syntax_Const.lex_t_lid r1)
in (FStar_Syntax_Syntax.fvar _156_444 FStar_Syntax_Syntax.Delta_constant None))
in ((_156_445), ((FStar_Syntax_Syntax.U_name (utop))::[])))
in FStar_Syntax_Syntax.Tm_uinst (_156_446))
in (FStar_Syntax_Syntax.mk _156_447 None r1))
in (

let lex_top_t = (FStar_Syntax_Subst.close_univ_vars ((utop)::[]) lex_top_t)
in (

let dc_lextop = FStar_Syntax_Syntax.Sig_datacon (((lex_top), ((utop)::[]), (lex_top_t), (FStar_Syntax_Const.lex_t_lid), ((Prims.parse_int "0")), ([]), ([]), (r1)))
in (

let ucons1 = (FStar_Syntax_Syntax.new_univ_name (Some (r2)))
in (

let ucons2 = (FStar_Syntax_Syntax.new_univ_name (Some (r2)))
in (

let lex_cons_t = (

let a = (let _156_448 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_name (ucons1))) None r2)
in (FStar_Syntax_Syntax.new_bv (Some (r2)) _156_448))
in (

let hd = (let _156_449 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.new_bv (Some (r2)) _156_449))
in (

let tl = (let _156_454 = (let _156_453 = (let _156_452 = (let _156_451 = (let _156_450 = (FStar_Ident.set_lid_range FStar_Syntax_Const.lex_t_lid r2)
in (FStar_Syntax_Syntax.fvar _156_450 FStar_Syntax_Syntax.Delta_constant None))
in ((_156_451), ((FStar_Syntax_Syntax.U_name (ucons2))::[])))
in FStar_Syntax_Syntax.Tm_uinst (_156_452))
in (FStar_Syntax_Syntax.mk _156_453 None r2))
in (FStar_Syntax_Syntax.new_bv (Some (r2)) _156_454))
in (

let res = (let _156_458 = (let _156_457 = (let _156_456 = (let _156_455 = (FStar_Ident.set_lid_range FStar_Syntax_Const.lex_t_lid r2)
in (FStar_Syntax_Syntax.fvar _156_455 FStar_Syntax_Syntax.Delta_constant None))
in ((_156_456), ((FStar_Syntax_Syntax.U_max ((FStar_Syntax_Syntax.U_name (ucons1))::(FStar_Syntax_Syntax.U_name (ucons2))::[]))::[])))
in FStar_Syntax_Syntax.Tm_uinst (_156_457))
in (FStar_Syntax_Syntax.mk _156_458 None r2))
in (let _156_459 = (FStar_Syntax_Syntax.mk_Total res)
in (FStar_Syntax_Util.arrow ((((a), (Some (FStar_Syntax_Syntax.imp_tag))))::(((hd), (None)))::(((tl), (None)))::[]) _156_459))))))
in (

let lex_cons_t = (FStar_Syntax_Subst.close_univ_vars ((ucons1)::(ucons2)::[]) lex_cons_t)
in (

let dc_lexcons = FStar_Syntax_Syntax.Sig_datacon (((lex_cons), ((ucons1)::(ucons2)::[]), (lex_cons_t), (FStar_Syntax_Const.lex_t_lid), ((Prims.parse_int "0")), ([]), ([]), (r2)))
in (let _156_461 = (let _156_460 = (FStar_TypeChecker_Env.get_range env)
in (((tc)::(dc_lextop)::(dc_lexcons)::[]), ([]), (lids), (_156_460)))
in FStar_Syntax_Syntax.Sig_bundle (_156_461)))))))))))))))
end
| _59_670 -> begin
(let _156_463 = (let _156_462 = (FStar_Syntax_Print.sigelt_to_string (FStar_Syntax_Syntax.Sig_bundle (((ses), ([]), (lids), (FStar_Range.dummyRange)))))
in (FStar_Util.format1 "Unexpected lex_t: %s\n" _156_462))
in (FStar_All.failwith _156_463))
end))))
and tc_assume : FStar_TypeChecker_Env.env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.formula  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.sigelt = (fun env lid phi quals r -> (

let env = (FStar_TypeChecker_Env.set_range env r)
in (

let _59_680 = (FStar_Syntax_Util.type_u ())
in (match (_59_680) with
| (k, _59_679) -> begin
(

let phi = (let _156_469 = (tc_check_trivial_guard env phi k)
in (FStar_All.pipe_right _156_469 (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Eager_unfolding)::[]) env)))
in (

let _59_682 = (FStar_TypeChecker_Util.check_uvars r phi)
in FStar_Syntax_Syntax.Sig_assume (((lid), (phi), (quals), (r)))))
end))))
and tc_inductive : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.sigelt Prims.list = (fun env ses quals lids -> (

let warn_positivity = (fun l r -> (let _156_479 = (let _156_478 = (FStar_Syntax_Print.lid_to_string l)
in (FStar_Util.format1 "Positivity check is not yet implemented (%s)" _156_478))
in (FStar_TypeChecker_Errors.diag r _156_479)))
in (

let env0 = env
in (

let tc_tycon = (fun env s -> (match (s) with
| FStar_Syntax_Syntax.Sig_inductive_typ (tc, uvs, tps, k, mutuals, data, quals, r) -> begin
(

let _59_705 = ()
in (

let _59_707 = (warn_positivity tc r)
in (

let _59_711 = (FStar_Syntax_Subst.open_term tps k)
in (match (_59_711) with
| (tps, k) -> begin
(

let _59_716 = (FStar_TypeChecker_TcTerm.tc_binders env tps)
in (match (_59_716) with
| (tps, env_tps, guard_params, us) -> begin
(

let _59_719 = (FStar_Syntax_Util.arrow_formals k)
in (match (_59_719) with
| (indices, t) -> begin
(

let _59_724 = (FStar_TypeChecker_TcTerm.tc_binders env_tps indices)
in (match (_59_724) with
| (indices, env', guard_indices, us') -> begin
(

let _59_732 = (

let _59_729 = (FStar_TypeChecker_TcTerm.tc_tot_or_gtot_term env' t)
in (match (_59_729) with
| (t, _59_727, g) -> begin
(let _156_486 = (let _156_485 = (let _156_484 = (FStar_TypeChecker_Rel.conj_guard guard_indices g)
in (FStar_TypeChecker_Rel.conj_guard guard_params _156_484))
in (FStar_TypeChecker_Rel.discharge_guard env' _156_485))
in ((t), (_156_486)))
end))
in (match (_59_732) with
| (t, guard) -> begin
(

let k = (let _156_487 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow indices _156_487))
in (

let _59_736 = (FStar_Syntax_Util.type_u ())
in (match (_59_736) with
| (t_type, u) -> begin
(

let _59_737 = (let _156_488 = (FStar_TypeChecker_Rel.teq env' t t_type)
in (FStar_TypeChecker_Rel.force_trivial_guard env' _156_488))
in (

let t_tc = (let _156_489 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow (FStar_List.append tps indices) _156_489))
in (

let tps = (FStar_Syntax_Subst.close_binders tps)
in (

let k = (FStar_Syntax_Subst.close tps k)
in (

let fv_tc = (FStar_Syntax_Syntax.lid_as_fv tc FStar_Syntax_Syntax.Delta_constant None)
in (let _156_490 = (FStar_TypeChecker_Env.push_let_binding env_tps (FStar_Util.Inr (fv_tc)) (([]), (t_tc)))
in ((_156_490), (FStar_Syntax_Syntax.Sig_inductive_typ (((tc), ([]), (tps), (k), (mutuals), (data), (quals), (r)))), (u), (guard))))))))
end)))
end))
end))
end))
end))
end))))
end
| _59_744 -> begin
(FStar_All.failwith "impossible")
end))
in (

let positive_if_pure = (fun _59_746 l -> ())
in (

let tc_data = (fun env tcs _59_1 -> (match (_59_1) with
| FStar_Syntax_Syntax.Sig_datacon (c, _uvs, t, tc_lid, ntps, quals, _mutual_tcs, r) -> begin
(

let _59_763 = ()
in (

let _59_798 = (

let tps_u_opt = (FStar_Util.find_map tcs (fun _59_767 -> (match (_59_767) with
| (se, u_tc) -> begin
if (let _156_503 = (let _156_502 = (FStar_Syntax_Util.lid_of_sigelt se)
in (FStar_Util.must _156_502))
in (FStar_Ident.lid_equals tc_lid _156_503)) then begin
(

let tps = (match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (_59_769, _59_771, tps, _59_774, _59_776, _59_778, _59_780, _59_782) -> begin
(FStar_All.pipe_right tps (FStar_List.map (fun _59_788 -> (match (_59_788) with
| (x, _59_787) -> begin
((x), (Some (FStar_Syntax_Syntax.imp_tag)))
end))))
end
| _59_790 -> begin
(FStar_All.failwith "Impossible")
end)
in Some (((tps), (u_tc))))
end else begin
None
end
end)))
in (match (tps_u_opt) with
| Some (x) -> begin
x
end
| None -> begin
if (FStar_Ident.lid_equals tc_lid FStar_Syntax_Const.exn_lid) then begin
(([]), (FStar_Syntax_Syntax.U_zero))
end else begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected data constructor"), (r)))))
end
end))
in (match (_59_798) with
| (tps, u_tc) -> begin
(

let _59_818 = (match ((let _156_505 = (FStar_Syntax_Subst.compress t)
in _156_505.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, res) -> begin
(

let _59_806 = (FStar_Util.first_N ntps bs)
in (match (_59_806) with
| (_59_804, bs') -> begin
(

let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow (((bs'), (res)))) None t.FStar_Syntax_Syntax.pos)
in (

let subst = (FStar_All.pipe_right tps (FStar_List.mapi (fun i _59_812 -> (match (_59_812) with
| (x, _59_811) -> begin
FStar_Syntax_Syntax.DB ((((ntps - ((Prims.parse_int "1") + i))), (x)))
end))))
in (let _156_508 = (FStar_Syntax_Subst.subst subst t)
in (FStar_Syntax_Util.arrow_formals _156_508))))
end))
end
| _59_815 -> begin
(([]), (t))
end)
in (match (_59_818) with
| (arguments, result) -> begin
(

let _59_819 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _156_511 = (FStar_Syntax_Print.lid_to_string c)
in (let _156_510 = (FStar_Syntax_Print.binders_to_string "->" arguments)
in (let _156_509 = (FStar_Syntax_Print.term_to_string result)
in (FStar_Util.print3 "Checking datacon  %s : %s -> %s \n" _156_511 _156_510 _156_509))))
end else begin
()
end
in (

let _59_824 = (tc_tparams env arguments)
in (match (_59_824) with
| (arguments, env', us) -> begin
(

let _59_827 = (FStar_TypeChecker_TcTerm.tc_trivial_guard env' result)
in (match (_59_827) with
| (result, res_lcomp) -> begin
(

let _59_832 = (match ((let _156_512 = (FStar_Syntax_Subst.compress res_lcomp.FStar_Syntax_Syntax.res_typ)
in _156_512.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_type (_59_829) -> begin
()
end
| ty -> begin
(let _156_517 = (let _156_516 = (let _156_515 = (let _156_514 = (FStar_Syntax_Print.term_to_string result)
in (let _156_513 = (FStar_Syntax_Print.term_to_string res_lcomp.FStar_Syntax_Syntax.res_typ)
in (FStar_Util.format2 "The type of %s is %s, but since this is the result type of a constructor its type should be Type" _156_514 _156_513)))
in ((_156_515), (r)))
in FStar_Syntax_Syntax.Error (_156_516))
in (Prims.raise _156_517))
end)
in (

let _59_837 = (FStar_Syntax_Util.head_and_args result)
in (match (_59_837) with
| (head, _59_836) -> begin
(

let _59_842 = (match ((let _156_518 = (FStar_Syntax_Subst.compress head)
in _156_518.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv) when (FStar_Syntax_Syntax.fv_eq_lid fv tc_lid) -> begin
()
end
| _59_841 -> begin
(let _156_523 = (let _156_522 = (let _156_521 = (let _156_520 = (FStar_Syntax_Print.lid_to_string tc_lid)
in (let _156_519 = (FStar_Syntax_Print.term_to_string head)
in (FStar_Util.format2 "Expected a constructor of type %s; got %s" _156_520 _156_519)))
in ((_156_521), (r)))
in FStar_Syntax_Syntax.Error (_156_522))
in (Prims.raise _156_523))
end)
in (

let g = (FStar_List.fold_left2 (fun g _59_848 u_x -> (match (_59_848) with
| (x, _59_847) -> begin
(

let _59_850 = ()
in (let _156_527 = (FStar_TypeChecker_Rel.universe_inequality u_x u_tc)
in (FStar_TypeChecker_Rel.conj_guard g _156_527)))
end)) FStar_TypeChecker_Rel.trivial_guard arguments us)
in (

let t = (let _156_531 = (let _156_529 = (FStar_All.pipe_right tps (FStar_List.map (fun _59_856 -> (match (_59_856) with
| (x, _59_855) -> begin
((x), (Some (FStar_Syntax_Syntax.Implicit (true))))
end))))
in (FStar_List.append _156_529 arguments))
in (let _156_530 = (FStar_Syntax_Syntax.mk_Total result)
in (FStar_Syntax_Util.arrow _156_531 _156_530)))
in ((FStar_Syntax_Syntax.Sig_datacon (((c), ([]), (t), (tc_lid), (ntps), (quals), ([]), (r)))), (g)))))
end)))
end))
end)))
end))
end)))
end
| _59_859 -> begin
(FStar_All.failwith "impossible")
end))
in (

let generalize_and_inst_within = (fun env g tcs datas -> (

let _59_865 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in (

let binders = (FStar_All.pipe_right tcs (FStar_List.map (fun _59_2 -> (match (_59_2) with
| FStar_Syntax_Syntax.Sig_inductive_typ (_59_869, _59_871, tps, k, _59_875, _59_877, _59_879, _59_881) -> begin
(let _156_542 = (let _156_541 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_All.pipe_left (FStar_Syntax_Util.arrow tps) _156_541))
in (FStar_Syntax_Syntax.null_binder _156_542))
end
| _59_885 -> begin
(FStar_All.failwith "Impossible")
end))))
in (

let binders' = (FStar_All.pipe_right datas (FStar_List.map (fun _59_3 -> (match (_59_3) with
| FStar_Syntax_Syntax.Sig_datacon (_59_889, _59_891, t, _59_894, _59_896, _59_898, _59_900, _59_902) -> begin
(FStar_Syntax_Syntax.null_binder t)
end
| _59_906 -> begin
(FStar_All.failwith "Impossible")
end))))
in (

let t = (let _156_544 = (FStar_Syntax_Syntax.mk_Total FStar_TypeChecker_Common.t_unit)
in (FStar_Syntax_Util.arrow (FStar_List.append binders binders') _156_544))
in (

let _59_909 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _156_545 = (FStar_TypeChecker_Normalize.term_to_string env t)
in (FStar_Util.print1 "@@@@@@Trying to generalize universes in %s\n" _156_545))
end else begin
()
end
in (

let _59_913 = (FStar_TypeChecker_Util.generalize_universes env t)
in (match (_59_913) with
| (uvs, t) -> begin
(

let _59_915 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _156_549 = (let _156_547 = (FStar_All.pipe_right uvs (FStar_List.map (fun u -> u.FStar_Ident.idText)))
in (FStar_All.pipe_right _156_547 (FStar_String.concat ", ")))
in (let _156_548 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "@@@@@@Generalized to (%s, %s)\n" _156_549 _156_548)))
end else begin
()
end
in (

let _59_919 = (FStar_Syntax_Subst.open_univ_vars uvs t)
in (match (_59_919) with
| (uvs, t) -> begin
(

let _59_923 = (FStar_Syntax_Util.arrow_formals t)
in (match (_59_923) with
| (args, _59_922) -> begin
(

let _59_926 = (FStar_Util.first_N (FStar_List.length binders) args)
in (match (_59_926) with
| (tc_types, data_types) -> begin
(

let tcs = (FStar_List.map2 (fun _59_930 se -> (match (_59_930) with
| (x, _59_929) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (tc, _59_934, tps, _59_937, mutuals, datas, quals, r) -> begin
(

let ty = (FStar_Syntax_Subst.close_univ_vars uvs x.FStar_Syntax_Syntax.sort)
in (

let _59_960 = (match ((let _156_552 = (FStar_Syntax_Subst.compress ty)
in _156_552.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
(

let _59_951 = (FStar_Util.first_N (FStar_List.length tps) binders)
in (match (_59_951) with
| (tps, rest) -> begin
(

let t = (match (rest) with
| [] -> begin
(FStar_Syntax_Util.comp_result c)
end
| _59_954 -> begin
(let _156_553 = (FStar_ST.read x.FStar_Syntax_Syntax.sort.FStar_Syntax_Syntax.tk)
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow (((rest), (c)))) _156_553 x.FStar_Syntax_Syntax.sort.FStar_Syntax_Syntax.pos))
end)
in ((tps), (t)))
end))
end
| _59_957 -> begin
(([]), (ty))
end)
in (match (_59_960) with
| (tps, t) -> begin
FStar_Syntax_Syntax.Sig_inductive_typ (((tc), (uvs), (tps), (t), (mutuals), (datas), (quals), (r)))
end)))
end
| _59_962 -> begin
(FStar_All.failwith "Impossible")
end)
end)) tc_types tcs)
in (

let datas = (match (uvs) with
| [] -> begin
datas
end
| _59_966 -> begin
(

let uvs_universes = (FStar_All.pipe_right uvs (FStar_List.map (fun _156_554 -> FStar_Syntax_Syntax.U_name (_156_554))))
in (

let tc_insts = (FStar_All.pipe_right tcs (FStar_List.map (fun _59_4 -> (match (_59_4) with
| FStar_Syntax_Syntax.Sig_inductive_typ (tc, _59_971, _59_973, _59_975, _59_977, _59_979, _59_981, _59_983) -> begin
((tc), (uvs_universes))
end
| _59_987 -> begin
(FStar_All.failwith "Impossible")
end))))
in (FStar_List.map2 (fun _59_992 d -> (match (_59_992) with
| (t, _59_991) -> begin
(match (d) with
| FStar_Syntax_Syntax.Sig_datacon (l, _59_996, _59_998, tc, ntps, quals, mutuals, r) -> begin
(

let ty = (let _156_558 = (FStar_Syntax_InstFV.instantiate tc_insts t.FStar_Syntax_Syntax.sort)
in (FStar_All.pipe_right _156_558 (FStar_Syntax_Subst.close_univ_vars uvs)))
in FStar_Syntax_Syntax.Sig_datacon (((l), (uvs), (ty), (tc), (ntps), (quals), (mutuals), (r))))
end
| _59_1008 -> begin
(FStar_All.failwith "Impossible")
end)
end)) data_types datas)))
end)
in ((tcs), (datas))))
end))
end))
end)))
end))))))))
in (

let _59_1018 = (FStar_All.pipe_right ses (FStar_List.partition (fun _59_5 -> (match (_59_5) with
| FStar_Syntax_Syntax.Sig_inductive_typ (_59_1012) -> begin
true
end
| _59_1015 -> begin
false
end))))
in (match (_59_1018) with
| (tys, datas) -> begin
(

let _59_1025 = if (FStar_All.pipe_right datas (FStar_Util.for_some (fun _59_6 -> (match (_59_6) with
| FStar_Syntax_Syntax.Sig_datacon (_59_1021) -> begin
false
end
| _59_1024 -> begin
true
end)))) then begin
(let _156_563 = (let _156_562 = (let _156_561 = (FStar_TypeChecker_Env.get_range env)
in (("Mutually defined type contains a non-inductive element"), (_156_561)))
in FStar_Syntax_Syntax.Error (_156_562))
in (Prims.raise _156_563))
end else begin
()
end
in (

let env0 = env
in (

let _59_1044 = (FStar_List.fold_right (fun tc _59_1032 -> (match (_59_1032) with
| (env, all_tcs, g) -> begin
(

let _59_1037 = (tc_tycon env tc)
in (match (_59_1037) with
| (env, tc, tc_u, guard) -> begin
(

let g' = (FStar_TypeChecker_Rel.universe_inequality FStar_Syntax_Syntax.U_zero tc_u)
in (

let _59_1039 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _156_566 = (FStar_Syntax_Print.sigelt_to_string tc)
in (FStar_Util.print1 "Checked inductive: %s\n" _156_566))
end else begin
()
end
in (let _156_568 = (let _156_567 = (FStar_TypeChecker_Rel.conj_guard guard g')
in (FStar_TypeChecker_Rel.conj_guard g _156_567))
in ((env), ((((tc), (tc_u)))::all_tcs), (_156_568)))))
end))
end)) tys ((env), ([]), (FStar_TypeChecker_Rel.trivial_guard)))
in (match (_59_1044) with
| (env, tcs, g) -> begin
(

let _59_1054 = (FStar_List.fold_right (fun se _59_1048 -> (match (_59_1048) with
| (datas, g) -> begin
(

let _59_1051 = (tc_data env tcs se)
in (match (_59_1051) with
| (data, g') -> begin
(let _156_571 = (FStar_TypeChecker_Rel.conj_guard g g')
in (((data)::datas), (_156_571)))
end))
end)) datas (([]), (g)))
in (match (_59_1054) with
| (datas, g) -> begin
(

let _59_1057 = (let _156_572 = (FStar_List.map Prims.fst tcs)
in (generalize_and_inst_within env0 g _156_572 datas))
in (match (_59_1057) with
| (tcs, datas) -> begin
(

let sig_bndle = (let _156_574 = (let _156_573 = (FStar_TypeChecker_Env.get_range env0)
in (((FStar_List.append tcs datas)), (quals), (lids), (_156_573)))
in FStar_Syntax_Syntax.Sig_bundle (_156_574))
in (

let datacon_typ = (fun data -> (match (data) with
| FStar_Syntax_Syntax.Sig_datacon (_59_1062, _59_1064, t, _59_1067, _59_1069, _59_1071, _59_1073, _59_1075) -> begin
t
end
| _59_1079 -> begin
(FStar_All.failwith "Impossible!")
end))
in (

let dr = FStar_Range.dummyRange
in (

let optimized_haseq_scheme = (fun _59_1082 -> (

let haseq_ty = (fun usubst us acc ty -> (

let _59_1109 = (match (ty) with
| FStar_Syntax_Syntax.Sig_inductive_typ (lid, _59_1091, bs, t, _59_1095, d_lids, _59_1098, _59_1100) -> begin
((lid), (bs), (t), (d_lids))
end
| _59_1104 -> begin
(FStar_All.failwith "Impossible!")
end)
in (match (_59_1109) with
| (lid, bs, t, d_lids) -> begin
(

let bs = (FStar_Syntax_Subst.subst_binders usubst bs)
in (

let t = (let _156_587 = (FStar_Syntax_Subst.shift_subst (FStar_List.length bs) usubst)
in (FStar_Syntax_Subst.subst _156_587 t))
in (

let _59_1114 = (FStar_Syntax_Subst.open_term bs t)
in (match (_59_1114) with
| (bs, t) -> begin
(

let ibs = (match ((let _156_588 = (FStar_Syntax_Subst.compress t)
in _156_588.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (ibs, _59_1117) -> begin
ibs
end
| _59_1121 -> begin
[]
end)
in (

let ibs = (FStar_Syntax_Subst.open_binders ibs)
in (

let ind = (let _156_591 = (FStar_Syntax_Syntax.fvar lid FStar_Syntax_Syntax.Delta_constant None)
in (let _156_590 = (FStar_List.map (fun u -> FStar_Syntax_Syntax.U_name (u)) us)
in (FStar_Syntax_Syntax.mk_Tm_uinst _156_591 _156_590)))
in (

let ind = (let _156_594 = (FStar_List.map (fun _59_1128 -> (match (_59_1128) with
| (bv, aq) -> begin
(let _156_593 = (FStar_Syntax_Syntax.bv_to_name bv)
in ((_156_593), (aq)))
end)) bs)
in (FStar_Syntax_Syntax.mk_Tm_app ind _156_594 None dr))
in (

let ind = (let _156_597 = (FStar_List.map (fun _59_1132 -> (match (_59_1132) with
| (bv, aq) -> begin
(let _156_596 = (FStar_Syntax_Syntax.bv_to_name bv)
in ((_156_596), (aq)))
end)) ibs)
in (FStar_Syntax_Syntax.mk_Tm_app ind _156_597 None dr))
in (

let haseq_ind = (let _156_599 = (let _156_598 = (FStar_Syntax_Syntax.as_arg ind)
in (_156_598)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.t_haseq _156_599 None dr))
in (

let bs' = (FStar_List.filter (fun b -> (

let _59_1143 = acc
in (match (_59_1143) with
| (_59_1137, en, _59_1140, _59_1142) -> begin
(

let opt = (let _156_602 = (let _156_601 = (FStar_Syntax_Util.type_u ())
in (Prims.fst _156_601))
in (FStar_TypeChecker_Rel.try_subtype' en (Prims.fst b).FStar_Syntax_Syntax.sort _156_602 false))
in (match (opt) with
| None -> begin
false
end
| Some (_59_1147) -> begin
true
end))
end))) bs)
in (

let haseq_bs = (FStar_List.fold_left (fun t b -> (let _156_608 = (let _156_607 = (let _156_606 = (let _156_605 = (FStar_Syntax_Syntax.bv_to_name (Prims.fst b))
in (FStar_Syntax_Syntax.as_arg _156_605))
in (_156_606)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.t_haseq _156_607 None dr))
in (FStar_Syntax_Util.mk_conj t _156_608))) FStar_Syntax_Util.t_true bs')
in (

let fml = (FStar_Syntax_Util.mk_imp haseq_bs haseq_ind)
in (

let fml = (

let _59_1154 = fml
in (let _156_614 = (let _156_613 = (let _156_612 = (let _156_611 = (let _156_610 = (let _156_609 = (FStar_Syntax_Syntax.as_arg haseq_ind)
in (_156_609)::[])
in (_156_610)::[])
in FStar_Syntax_Syntax.Meta_pattern (_156_611))
in ((fml), (_156_612)))
in FStar_Syntax_Syntax.Tm_meta (_156_613))
in {FStar_Syntax_Syntax.n = _156_614; FStar_Syntax_Syntax.tk = _59_1154.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = _59_1154.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = _59_1154.FStar_Syntax_Syntax.vars}))
in (

let fml = (FStar_List.fold_right (fun b t -> (let _156_620 = (let _156_619 = (let _156_618 = (let _156_617 = (FStar_Syntax_Subst.close ((b)::[]) t)
in (FStar_Syntax_Util.abs (((((Prims.fst b)), (None)))::[]) _156_617 None))
in (FStar_Syntax_Syntax.as_arg _156_618))
in (_156_619)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.tforall _156_620 None dr))) ibs fml)
in (

let fml = (FStar_List.fold_right (fun b t -> (let _156_626 = (let _156_625 = (let _156_624 = (let _156_623 = (FStar_Syntax_Subst.close ((b)::[]) t)
in (FStar_Syntax_Util.abs (((((Prims.fst b)), (None)))::[]) _156_623 None))
in (FStar_Syntax_Syntax.as_arg _156_624))
in (_156_625)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.tforall _156_626 None dr))) bs fml)
in (

let guard = (FStar_Syntax_Util.mk_conj haseq_bs fml)
in (

let _59_1168 = acc
in (match (_59_1168) with
| (l_axioms, env, guard', cond') -> begin
(

let env = (FStar_TypeChecker_Env.push_binders env bs)
in (

let env = (FStar_TypeChecker_Env.push_binders env ibs)
in (

let t_datas = (FStar_List.filter (fun s -> (match (s) with
| FStar_Syntax_Syntax.Sig_datacon (_59_1173, _59_1175, _59_1177, t_lid, _59_1180, _59_1182, _59_1184, _59_1186) -> begin
(t_lid = lid)
end
| _59_1190 -> begin
(FStar_All.failwith "Impossible")
end)) datas)
in (

let haseq_data = (fun data -> (

let dt = (datacon_typ data)
in (

let dt = (FStar_Syntax_Subst.subst usubst dt)
in (match ((let _156_630 = (FStar_Syntax_Subst.compress dt)
in _156_630.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (dbs, _59_1198) -> begin
(

let dbs = (let _156_631 = (FStar_List.splitAt (FStar_List.length bs) dbs)
in (Prims.snd _156_631))
in (

let dbs = (let _156_632 = (FStar_Syntax_Subst.opening_of_binders bs)
in (FStar_Syntax_Subst.subst_binders _156_632 dbs))
in (

let dbs = (FStar_Syntax_Subst.open_binders dbs)
in (

let cond = (FStar_List.fold_left (fun t b -> (

let haseq_b = (let _156_636 = (let _156_635 = (FStar_Syntax_Syntax.as_arg (Prims.fst b).FStar_Syntax_Syntax.sort)
in (_156_635)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.t_haseq _156_636 None dr))
in (

let sort_range = (Prims.fst b).FStar_Syntax_Syntax.sort.FStar_Syntax_Syntax.pos
in (

let haseq_b = (let _156_638 = (let _156_637 = (FStar_Syntax_Print.term_to_string ind)
in (FStar_Util.format1 "Failed to prove that the type \'%s\' supports decidable equality because of this argument; add the \'noeq\' qualifier" _156_637))
in (FStar_TypeChecker_Util.label _156_638 sort_range haseq_b))
in (FStar_Syntax_Util.mk_conj t haseq_b))))) FStar_Syntax_Util.t_true dbs)
in (FStar_List.fold_right (fun b t -> (let _156_644 = (let _156_643 = (let _156_642 = (let _156_641 = (FStar_Syntax_Subst.close ((b)::[]) t)
in (FStar_Syntax_Util.abs (((((Prims.fst b)), (None)))::[]) _156_641 None))
in (FStar_Syntax_Syntax.as_arg _156_642))
in (_156_643)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.tforall _156_644 None dr))) dbs cond)))))
end
| _59_1213 -> begin
FStar_Syntax_Util.t_true
end))))
in (

let cond = (FStar_List.fold_left (fun acc d -> (let _156_647 = (haseq_data d)
in (FStar_Syntax_Util.mk_conj acc _156_647))) FStar_Syntax_Util.t_true t_datas)
in (

let axiom_lid = (FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns (((FStar_Ident.id_of_text (Prims.strcat lid.FStar_Ident.ident.FStar_Ident.idText "_haseq")))::[])))
in (let _156_649 = (FStar_Syntax_Util.mk_conj guard' guard)
in (let _156_648 = (FStar_Syntax_Util.mk_conj cond' cond)
in (((FStar_List.append l_axioms ((((axiom_lid), (fml)))::[]))), (env), (_156_649), (_156_648))))))))))
end)))))))))))))))
end))))
end)))
in (

let us = (

let ty = (FStar_List.hd tcs)
in (match (ty) with
| FStar_Syntax_Syntax.Sig_inductive_typ (_59_1220, us, _59_1223, _59_1225, _59_1227, _59_1229, _59_1231, _59_1233) -> begin
us
end
| _59_1237 -> begin
(FStar_All.failwith "Impossible!")
end))
in (

let _59_1241 = (FStar_Syntax_Subst.univ_var_opening us)
in (match (_59_1241) with
| (usubst, us) -> begin
(

let env = (FStar_TypeChecker_Env.push_sigelt env0 sig_bndle)
in (

let _59_1243 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.push "haseq")
in (

let _59_1245 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.encode_sig env sig_bndle)
in (

let env = (FStar_TypeChecker_Env.push_univ_vars env us)
in (

let _59_1252 = (FStar_List.fold_left (haseq_ty usubst us) (([]), (env), (FStar_Syntax_Util.t_true), (FStar_Syntax_Util.t_true)) tcs)
in (match (_59_1252) with
| (axioms, env, guard, cond) -> begin
(

let phi = (FStar_Syntax_Util.mk_imp guard cond)
in (

let _59_1257 = (FStar_TypeChecker_TcTerm.tc_trivial_guard env phi)
in (match (_59_1257) with
| (phi, _59_1256) -> begin
(

let _59_1258 = if (FStar_TypeChecker_Env.should_verify env) then begin
(let _156_650 = (FStar_TypeChecker_Rel.guard_of_guard_formula (FStar_TypeChecker_Common.NonTrivial (phi)))
in (FStar_TypeChecker_Rel.force_trivial_guard env _156_650))
end else begin
()
end
in (

let ses = (FStar_List.fold_left (fun l _59_1263 -> (match (_59_1263) with
| (lid, fml) -> begin
(

let se = (tc_assume env lid fml [] dr)
in (FStar_List.append l ((se)::[])))
end)) [] axioms)
in (

let _59_1266 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.pop "haseq")
in ses)))
end)))
end))))))
end)))))
in (

let unoptimized_haseq_scheme = (fun _59_1269 -> (

let mutuals = (FStar_List.map (fun ty -> (match (ty) with
| FStar_Syntax_Syntax.Sig_inductive_typ (lid, _59_1274, _59_1276, _59_1278, _59_1280, _59_1282, _59_1284, _59_1286) -> begin
lid
end
| _59_1290 -> begin
(FStar_All.failwith "Impossible!")
end)) tcs)
in (

let haseq_ty = (fun usubst us acc ty -> (

let _59_1317 = (match (ty) with
| FStar_Syntax_Syntax.Sig_inductive_typ (lid, _59_1299, bs, t, _59_1303, d_lids, _59_1306, _59_1308) -> begin
((lid), (bs), (t), (d_lids))
end
| _59_1312 -> begin
(FStar_All.failwith "Impossible!")
end)
in (match (_59_1317) with
| (lid, bs, t, d_lids) -> begin
(

let bs = (FStar_Syntax_Subst.subst_binders usubst bs)
in (

let t = (let _156_664 = (FStar_Syntax_Subst.shift_subst (FStar_List.length bs) usubst)
in (FStar_Syntax_Subst.subst _156_664 t))
in (

let _59_1322 = (FStar_Syntax_Subst.open_term bs t)
in (match (_59_1322) with
| (bs, t) -> begin
(

let ibs = (match ((let _156_665 = (FStar_Syntax_Subst.compress t)
in _156_665.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (ibs, _59_1325) -> begin
ibs
end
| _59_1329 -> begin
[]
end)
in (

let ibs = (FStar_Syntax_Subst.open_binders ibs)
in (

let ind = (let _156_668 = (FStar_Syntax_Syntax.fvar lid FStar_Syntax_Syntax.Delta_constant None)
in (let _156_667 = (FStar_List.map (fun u -> FStar_Syntax_Syntax.U_name (u)) us)
in (FStar_Syntax_Syntax.mk_Tm_uinst _156_668 _156_667)))
in (

let ind = (let _156_671 = (FStar_List.map (fun _59_1336 -> (match (_59_1336) with
| (bv, aq) -> begin
(let _156_670 = (FStar_Syntax_Syntax.bv_to_name bv)
in ((_156_670), (aq)))
end)) bs)
in (FStar_Syntax_Syntax.mk_Tm_app ind _156_671 None dr))
in (

let ind = (let _156_674 = (FStar_List.map (fun _59_1340 -> (match (_59_1340) with
| (bv, aq) -> begin
(let _156_673 = (FStar_Syntax_Syntax.bv_to_name bv)
in ((_156_673), (aq)))
end)) ibs)
in (FStar_Syntax_Syntax.mk_Tm_app ind _156_674 None dr))
in (

let haseq_ind = (let _156_676 = (let _156_675 = (FStar_Syntax_Syntax.as_arg ind)
in (_156_675)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.t_haseq _156_676 None dr))
in (

let rec is_mutual = (fun t -> (match ((let _156_680 = (FStar_Syntax_Subst.compress t)
in _156_680.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(FStar_List.existsb (fun lid -> (FStar_Ident.lid_equals lid fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)) mutuals)
end
| FStar_Syntax_Syntax.Tm_uinst (t', _59_1351) -> begin
(is_mutual t')
end
| FStar_Syntax_Syntax.Tm_refine (bv, t') -> begin
(is_mutual bv.FStar_Syntax_Syntax.sort)
end
| FStar_Syntax_Syntax.Tm_app (t', args) -> begin
if (is_mutual t') then begin
true
end else begin
(let _156_682 = (FStar_List.map Prims.fst args)
in (exists_mutual _156_682))
end
end
| FStar_Syntax_Syntax.Tm_meta (t', _59_1364) -> begin
(is_mutual t')
end
| _59_1368 -> begin
false
end))
and exists_mutual = (fun _59_7 -> (match (_59_7) with
| [] -> begin
false
end
| (hd)::tl -> begin
((is_mutual hd) || (exists_mutual tl))
end))
in (

let haseq_data = (fun acc data -> (

let dt = (datacon_typ data)
in (

let dt = (FStar_Syntax_Subst.subst usubst dt)
in (match ((let _156_688 = (FStar_Syntax_Subst.compress dt)
in _156_688.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (dbs, _59_1381) -> begin
(

let dbs = (let _156_689 = (FStar_List.splitAt (FStar_List.length bs) dbs)
in (Prims.snd _156_689))
in (

let dbs = (let _156_690 = (FStar_Syntax_Subst.opening_of_binders bs)
in (FStar_Syntax_Subst.subst_binders _156_690 dbs))
in (

let dbs = (FStar_Syntax_Subst.open_binders dbs)
in (

let cond = (FStar_List.fold_left (fun t b -> (

let sort = (Prims.fst b).FStar_Syntax_Syntax.sort
in (

let haseq_sort = (let _156_694 = (let _156_693 = (FStar_Syntax_Syntax.as_arg (Prims.fst b).FStar_Syntax_Syntax.sort)
in (_156_693)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.t_haseq _156_694 None dr))
in (

let haseq_sort = if (is_mutual sort) then begin
(FStar_Syntax_Util.mk_imp haseq_ind haseq_sort)
end else begin
haseq_sort
end
in (FStar_Syntax_Util.mk_conj t haseq_sort))))) FStar_Syntax_Util.t_true dbs)
in (

let cond = (FStar_List.fold_right (fun b t -> (let _156_700 = (let _156_699 = (let _156_698 = (let _156_697 = (FStar_Syntax_Subst.close ((b)::[]) t)
in (FStar_Syntax_Util.abs (((((Prims.fst b)), (None)))::[]) _156_697 None))
in (FStar_Syntax_Syntax.as_arg _156_698))
in (_156_699)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.tforall _156_700 None dr))) dbs cond)
in (FStar_Syntax_Util.mk_conj acc cond))))))
end
| _59_1397 -> begin
acc
end))))
in (

let t_datas = (FStar_List.filter (fun s -> (match (s) with
| FStar_Syntax_Syntax.Sig_datacon (_59_1400, _59_1402, _59_1404, t_lid, _59_1407, _59_1409, _59_1411, _59_1413) -> begin
(t_lid = lid)
end
| _59_1417 -> begin
(FStar_All.failwith "Impossible")
end)) datas)
in (

let data_cond = (FStar_List.fold_left haseq_data FStar_Syntax_Util.t_true t_datas)
in (

let fml = (FStar_Syntax_Util.mk_imp data_cond haseq_ind)
in (

let fml = (

let _59_1421 = fml
in (let _156_707 = (let _156_706 = (let _156_705 = (let _156_704 = (let _156_703 = (let _156_702 = (FStar_Syntax_Syntax.as_arg haseq_ind)
in (_156_702)::[])
in (_156_703)::[])
in FStar_Syntax_Syntax.Meta_pattern (_156_704))
in ((fml), (_156_705)))
in FStar_Syntax_Syntax.Tm_meta (_156_706))
in {FStar_Syntax_Syntax.n = _156_707; FStar_Syntax_Syntax.tk = _59_1421.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = _59_1421.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = _59_1421.FStar_Syntax_Syntax.vars}))
in (

let fml = (FStar_List.fold_right (fun b t -> (let _156_713 = (let _156_712 = (let _156_711 = (let _156_710 = (FStar_Syntax_Subst.close ((b)::[]) t)
in (FStar_Syntax_Util.abs (((((Prims.fst b)), (None)))::[]) _156_710 None))
in (FStar_Syntax_Syntax.as_arg _156_711))
in (_156_712)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.tforall _156_713 None dr))) ibs fml)
in (

let fml = (FStar_List.fold_right (fun b t -> (let _156_719 = (let _156_718 = (let _156_717 = (let _156_716 = (FStar_Syntax_Subst.close ((b)::[]) t)
in (FStar_Syntax_Util.abs (((((Prims.fst b)), (None)))::[]) _156_716 None))
in (FStar_Syntax_Syntax.as_arg _156_717))
in (_156_718)::[])
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.tforall _156_719 None dr))) bs fml)
in (FStar_Syntax_Util.mk_conj acc fml)))))))))))))))
end))))
end)))
in (

let _59_1451 = (

let ty = (FStar_List.hd tcs)
in (match (ty) with
| FStar_Syntax_Syntax.Sig_inductive_typ (lid, us, _59_1434, _59_1436, _59_1438, _59_1440, _59_1442, _59_1444) -> begin
((lid), (us))
end
| _59_1448 -> begin
(FStar_All.failwith "Impossible!")
end))
in (match (_59_1451) with
| (lid, us) -> begin
(

let _59_1454 = (FStar_Syntax_Subst.univ_var_opening us)
in (match (_59_1454) with
| (usubst, us) -> begin
(

let fml = (FStar_List.fold_left (haseq_ty usubst us) FStar_Syntax_Util.t_true tcs)
in (

let env = (FStar_TypeChecker_Env.push_sigelt env0 sig_bndle)
in (

let _59_1457 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.push "haseq")
in (

let _59_1459 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.encode_sig env sig_bndle)
in (

let env = (FStar_TypeChecker_Env.push_univ_vars env us)
in (

let se = (let _156_720 = (FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns (((FStar_Ident.id_of_text (Prims.strcat lid.FStar_Ident.ident.FStar_Ident.idText "_haseq")))::[])))
in (tc_assume env _156_720 fml [] dr))
in (

let _59_1463 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.pop "haseq")
in (se)::[])))))))
end))
end)))))
in (

let skip_prims_type = (fun _59_1466 -> (

let lid = (

let ty = (FStar_List.hd tcs)
in (match (ty) with
| FStar_Syntax_Syntax.Sig_inductive_typ (lid, _59_1471, _59_1473, _59_1475, _59_1477, _59_1479, _59_1481, _59_1483) -> begin
lid
end
| _59_1487 -> begin
(FStar_All.failwith "Impossible")
end))
in (

let types_to_skip = ("c_False")::("c_True")::("equals")::("h_equals")::("c_and")::("c_or")::[]
in (FStar_List.existsb (fun s -> (s = lid.FStar_Ident.ident.FStar_Ident.idText)) types_to_skip))))
in (

let is_noeq = (FStar_List.existsb (fun q -> (q = FStar_Syntax_Syntax.Noeq)) quals)
in if ((((FStar_List.length tcs) = (Prims.parse_int "0")) || ((FStar_Ident.lid_equals env.FStar_TypeChecker_Env.curmodule FStar_Syntax_Const.prims_lid) && (skip_prims_type ()))) || is_noeq) then begin
(sig_bndle)::[]
end else begin
(

let is_unopteq = (FStar_List.existsb (fun q -> (q = FStar_Syntax_Syntax.Unopteq)) quals)
in (

let ses = if is_unopteq then begin
(unoptimized_haseq_scheme ())
end else begin
(optimized_haseq_scheme ())
end
in (let _156_728 = (let _156_727 = (let _156_726 = (FStar_TypeChecker_Env.get_range env0)
in (((FStar_List.append tcs datas)), (quals), (lids), (_156_726)))
in FStar_Syntax_Syntax.Sig_bundle (_156_727))
in (_156_728)::ses)))
end)))))))
end))
end))
end))))
end)))))))))
and tc_decl : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt  ->  (FStar_Syntax_Syntax.sigelt Prims.list * FStar_TypeChecker_Env.env) = (fun env se -> (

let env = (set_hint_correlator env se)
in (

let _59_1499 = (FStar_TypeChecker_Util.check_sigelt_quals se)
in (match (se) with
| (FStar_Syntax_Syntax.Sig_inductive_typ (_)) | (FStar_Syntax_Syntax.Sig_datacon (_)) -> begin
(FStar_All.failwith "Impossible bare data-constructor")
end
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, lids, r) when (FStar_All.pipe_right lids (FStar_Util.for_some (FStar_Ident.lid_equals FStar_Syntax_Const.lex_t_lid))) -> begin
(

let env = (FStar_TypeChecker_Env.set_range env r)
in (

let se = (tc_lex_t env ses quals lids)
in (let _156_731 = (FStar_TypeChecker_Env.push_sigelt env se)
in (((se)::[]), (_156_731)))))
end
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, lids, r) -> begin
(

let env = (FStar_TypeChecker_Env.set_range env r)
in (

let ses = (tc_inductive env ses quals lids)
in (

let env = (FStar_List.fold_left (fun env' se -> (FStar_TypeChecker_Env.push_sigelt env' se)) env ses)
in ((ses), (env)))))
end
| FStar_Syntax_Syntax.Sig_pragma (p, r) -> begin
(

let set_options = (fun t s -> (match ((FStar_Options.set_options t s)) with
| FStar_Getopt.Success -> begin
()
end
| FStar_Getopt.Help -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Failed to process pragma: use \'fstar --help\' to see which options are available"), (r)))))
end
| FStar_Getopt.Error (s) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((((Prims.strcat "Failed to process pragma: " s)), (r)))))
end))
in (match (p) with
| FStar_Syntax_Syntax.SetOptions (o) -> begin
(

let _59_1539 = (set_options FStar_Options.Set o)
in (((se)::[]), (env)))
end
| FStar_Syntax_Syntax.ResetOptions (sopt) -> begin
(

let _59_1543 = (let _156_738 = (FStar_Options.restore_cmd_line_options false)
in (FStar_All.pipe_right _156_738 Prims.ignore))
in (

let _59_1548 = (match (sopt) with
| None -> begin
()
end
| Some (s) -> begin
(set_options FStar_Options.Reset s)
end)
in (

let _59_1550 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.refresh ())
in (((se)::[]), (env)))))
end))
end
| FStar_Syntax_Syntax.Sig_new_effect_for_free (_59_1553) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Syntax_Syntax.Sig_new_effect (ne, r) -> begin
(

let ne = (tc_eff_decl env ne)
in (

let se = FStar_Syntax_Syntax.Sig_new_effect (((ne), (r)))
in (

let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (

let _59_1569 = (FStar_All.pipe_right ne.FStar_Syntax_Syntax.actions (FStar_List.fold_left (fun _59_1564 a -> (match (_59_1564) with
| (env, ses) -> begin
(

let se_let = (FStar_Syntax_Util.action_as_lb a)
in (let _156_741 = (FStar_TypeChecker_Env.push_sigelt env se_let)
in ((_156_741), ((se_let)::ses))))
end)) ((env), ((se)::[]))))
in (match (_59_1569) with
| (env, ses) -> begin
(((se)::[]), (env))
end)))))
end
| FStar_Syntax_Syntax.Sig_sub_effect (sub, r) -> begin
(

let ed_src = (FStar_TypeChecker_Env.get_effect_decl env sub.FStar_Syntax_Syntax.source)
in (

let ed_tgt = (FStar_TypeChecker_Env.get_effect_decl env sub.FStar_Syntax_Syntax.target)
in (

let _59_1578 = (let _156_742 = (FStar_TypeChecker_Env.lookup_effect_lid env sub.FStar_Syntax_Syntax.source)
in (monad_signature env sub.FStar_Syntax_Syntax.source _156_742))
in (match (_59_1578) with
| (a, wp_a_src) -> begin
(

let _59_1581 = (let _156_743 = (FStar_TypeChecker_Env.lookup_effect_lid env sub.FStar_Syntax_Syntax.target)
in (monad_signature env sub.FStar_Syntax_Syntax.target _156_743))
in (match (_59_1581) with
| (b, wp_b_tgt) -> begin
(

let wp_a_tgt = (let _156_747 = (let _156_746 = (let _156_745 = (let _156_744 = (FStar_Syntax_Syntax.bv_to_name a)
in ((b), (_156_744)))
in FStar_Syntax_Syntax.NT (_156_745))
in (_156_746)::[])
in (FStar_Syntax_Subst.subst _156_747 wp_b_tgt))
in (

let expected_k = (let _156_752 = (let _156_750 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_749 = (let _156_748 = (FStar_Syntax_Syntax.null_binder wp_a_src)
in (_156_748)::[])
in (_156_750)::_156_749))
in (let _156_751 = (FStar_Syntax_Syntax.mk_Total wp_a_tgt)
in (FStar_Syntax_Util.arrow _156_752 _156_751)))
in (

let repr_type = (fun eff_name a wp -> (

let no_reify = (fun l -> (let _156_764 = (let _156_763 = (let _156_762 = (FStar_Util.format1 "Effect %s cannot be reified" l.FStar_Ident.str)
in (let _156_761 = (FStar_TypeChecker_Env.get_range env)
in ((_156_762), (_156_761))))
in FStar_Syntax_Syntax.Error (_156_763))
in (Prims.raise _156_764)))
in (match ((FStar_TypeChecker_Env.effect_decl_opt env eff_name)) with
| None -> begin
(no_reify eff_name)
end
| Some (ed) -> begin
(

let repr = (FStar_TypeChecker_Env.inst_effect_fun_with ((FStar_Syntax_Syntax.U_unknown)::[]) env ed (([]), (ed.FStar_Syntax_Syntax.repr)))
in if (not ((FStar_All.pipe_right ed.FStar_Syntax_Syntax.qualifiers (FStar_List.contains FStar_Syntax_Syntax.Reifiable)))) then begin
(no_reify eff_name)
end else begin
(let _156_771 = (let _156_769 = (let _156_768 = (let _156_767 = (FStar_Syntax_Syntax.as_arg a)
in (let _156_766 = (let _156_765 = (FStar_Syntax_Syntax.as_arg wp)
in (_156_765)::[])
in (_156_767)::_156_766))
in ((repr), (_156_768)))
in FStar_Syntax_Syntax.Tm_app (_156_769))
in (let _156_770 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Syntax_Syntax.mk _156_771 None _156_770)))
end)
end)))
in (

let _59_1622 = (match (((sub.FStar_Syntax_Syntax.lift), (sub.FStar_Syntax_Syntax.lift_wp))) with
| (None, None) -> begin
(FStar_All.failwith "Impossible")
end
| (lift, Some (_59_1599, lift_wp)) -> begin
(let _156_772 = (check_and_gen env lift_wp expected_k)
in ((lift), (_156_772)))
end
| (Some (what, lift), None) -> begin
(

let dmff_env = (FStar_TypeChecker_DMFF.empty env (FStar_TypeChecker_TcTerm.tc_constant FStar_Range.dummyRange))
in (

let _59_1615 = (FStar_TypeChecker_DMFF.star_expr dmff_env lift)
in (match (_59_1615) with
| (_59_1612, lift_wp, lift_elab) -> begin
(

let _59_1616 = (recheck_debug "lift-wp" env lift_wp)
in (

let _59_1618 = (recheck_debug "lift-elab" env lift_elab)
in ((Some ((([]), (lift_elab)))), ((([]), (lift_wp))))))
end)))
end)
in (match (_59_1622) with
| (lift, lift_wp) -> begin
(

let lax = env.FStar_TypeChecker_Env.lax
in (

let env = (

let _59_1624 = env
in {FStar_TypeChecker_Env.solver = _59_1624.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_1624.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_1624.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_1624.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_1624.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_1624.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_1624.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_1624.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_1624.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_1624.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_1624.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _59_1624.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _59_1624.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _59_1624.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _59_1624.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_1624.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _59_1624.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _59_1624.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = true; FStar_TypeChecker_Env.lax_universes = _59_1624.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _59_1624.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_1624.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_1624.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = _59_1624.FStar_TypeChecker_Env.qname_and_index})
in (

let lift = (match (lift) with
| None -> begin
None
end
| Some (_59_1629, lift) -> begin
(

let _59_1635 = (let _156_773 = (FStar_TypeChecker_Env.lookup_effect_lid env sub.FStar_Syntax_Syntax.source)
in (monad_signature env sub.FStar_Syntax_Syntax.source _156_773))
in (match (_59_1635) with
| (a, wp_a_src) -> begin
(

let wp_a = (FStar_Syntax_Syntax.new_bv None wp_a_src)
in (

let a_typ = (FStar_Syntax_Syntax.bv_to_name a)
in (

let wp_a_typ = (FStar_Syntax_Syntax.bv_to_name wp_a)
in (

let repr_f = (repr_type sub.FStar_Syntax_Syntax.source a_typ wp_a_typ)
in (

let repr_result = (

let lift_wp = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.EraseUniverses)::(FStar_TypeChecker_Normalize.AllowUnboundUniverses)::[]) env (Prims.snd lift_wp))
in (

let lift_wp_a = (let _156_780 = (let _156_778 = (let _156_777 = (let _156_776 = (FStar_Syntax_Syntax.as_arg a_typ)
in (let _156_775 = (let _156_774 = (FStar_Syntax_Syntax.as_arg wp_a_typ)
in (_156_774)::[])
in (_156_776)::_156_775))
in ((lift_wp), (_156_777)))
in FStar_Syntax_Syntax.Tm_app (_156_778))
in (let _156_779 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Syntax_Syntax.mk _156_780 None _156_779)))
in (repr_type sub.FStar_Syntax_Syntax.target a_typ lift_wp_a)))
in (

let expected_k = (let _156_787 = (let _156_785 = (FStar_Syntax_Syntax.mk_binder a)
in (let _156_784 = (let _156_783 = (FStar_Syntax_Syntax.mk_binder wp_a)
in (let _156_782 = (let _156_781 = (FStar_Syntax_Syntax.null_binder repr_f)
in (_156_781)::[])
in (_156_783)::_156_782))
in (_156_785)::_156_784))
in (let _156_786 = (FStar_Syntax_Syntax.mk_Total repr_result)
in (FStar_Syntax_Util.arrow _156_787 _156_786)))
in (

let _59_1649 = (FStar_TypeChecker_TcTerm.tc_tot_or_gtot_term env expected_k)
in (match (_59_1649) with
| (expected_k, _59_1646, _59_1648) -> begin
(

let lift = (check_and_gen env lift expected_k)
in Some (lift))
end))))))))
end))
end)
in (

let env = (

let _59_1652 = env
in {FStar_TypeChecker_Env.solver = _59_1652.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_1652.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_1652.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_1652.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_1652.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_1652.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_1652.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_1652.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_1652.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_1652.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_1652.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _59_1652.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _59_1652.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _59_1652.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _59_1652.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_1652.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _59_1652.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _59_1652.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = lax; FStar_TypeChecker_Env.lax_universes = _59_1652.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _59_1652.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_1652.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_1652.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = _59_1652.FStar_TypeChecker_Env.qname_and_index})
in (

let sub = (

let _59_1655 = sub
in {FStar_Syntax_Syntax.source = _59_1655.FStar_Syntax_Syntax.source; FStar_Syntax_Syntax.target = _59_1655.FStar_Syntax_Syntax.target; FStar_Syntax_Syntax.lift_wp = Some (lift_wp); FStar_Syntax_Syntax.lift = lift})
in (

let se = FStar_Syntax_Syntax.Sig_sub_effect (((sub), (r)))
in (

let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (((se)::[]), (env)))))))))
end)))))
end))
end))))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (lid, uvs, tps, c, tags, r) -> begin
(

let _59_1668 = ()
in (

let env0 = env
in (

let env = (FStar_TypeChecker_Env.set_range env r)
in (

let _59_1674 = (FStar_Syntax_Subst.open_comp tps c)
in (match (_59_1674) with
| (tps, c) -> begin
(

let _59_1678 = (tc_tparams env tps)
in (match (_59_1678) with
| (tps, env, us) -> begin
(

let _59_1682 = (FStar_TypeChecker_TcTerm.tc_comp env c)
in (match (_59_1682) with
| (c, u, g) -> begin
(

let _59_1683 = (FStar_TypeChecker_Rel.force_trivial_guard env g)
in (

let tps = (FStar_Syntax_Subst.close_binders tps)
in (

let c = (FStar_Syntax_Subst.close_comp tps c)
in (

let _59_1689 = (let _156_788 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow (((tps), (c)))) None r)
in (FStar_TypeChecker_Util.generalize_universes env0 _156_788))
in (match (_59_1689) with
| (uvs, t) -> begin
(

let _59_1708 = (match ((let _156_790 = (let _156_789 = (FStar_Syntax_Subst.compress t)
in _156_789.FStar_Syntax_Syntax.n)
in ((tps), (_156_790)))) with
| ([], FStar_Syntax_Syntax.Tm_arrow (_59_1692, c)) -> begin
(([]), (c))
end
| (_59_1698, FStar_Syntax_Syntax.Tm_arrow (tps, c)) -> begin
((tps), (c))
end
| _59_1705 -> begin
(FStar_All.failwith "Impossible")
end)
in (match (_59_1708) with
| (tps, c) -> begin
(

let _59_1709 = if (((FStar_List.length uvs) <> (Prims.parse_int "1")) && (not ((FStar_Ident.lid_equals lid FStar_Syntax_Const.effect_Lemma_lid)))) then begin
(let _156_795 = (let _156_794 = (let _156_793 = (let _156_792 = (FStar_Syntax_Print.lid_to_string lid)
in (let _156_791 = (FStar_All.pipe_right (FStar_List.length uvs) FStar_Util.string_of_int)
in (FStar_Util.format2 "Effect abbreviations must be polymorphic in exactly 1 universe; %s has %s universes" _156_792 _156_791)))
in ((_156_793), (r)))
in FStar_Syntax_Syntax.Error (_156_794))
in (Prims.raise _156_795))
end else begin
()
end
in (

let se = FStar_Syntax_Syntax.Sig_effect_abbrev (((lid), (uvs), (tps), (c), (tags), (r)))
in (

let env = (FStar_TypeChecker_Env.push_sigelt env0 se)
in (((se)::[]), (env)))))
end))
end)))))
end))
end))
end)))))
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, uvs, t, quals, r) -> begin
(

let env = (FStar_TypeChecker_Env.set_range env r)
in (

let _59_1721 = ()
in (

let _59_1725 = (let _156_797 = (let _156_796 = (FStar_Syntax_Util.type_u ())
in (Prims.fst _156_796))
in (check_and_gen env t _156_797))
in (match (_59_1725) with
| (uvs, t) -> begin
(

let se = FStar_Syntax_Syntax.Sig_declare_typ (((lid), (uvs), (t), (quals), (r)))
in (

let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (((se)::[]), (env))))
end))))
end
| FStar_Syntax_Syntax.Sig_assume (lid, phi, quals, r) -> begin
(

let se = (tc_assume env lid phi quals r)
in (

let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (((se)::[]), (env))))
end
| FStar_Syntax_Syntax.Sig_main (e, r) -> begin
(

let env = (FStar_TypeChecker_Env.set_range env r)
in (

let env = (FStar_TypeChecker_Env.set_expected_typ env FStar_TypeChecker_Common.t_unit)
in (

let _59_1745 = (FStar_TypeChecker_TcTerm.tc_term env e)
in (match (_59_1745) with
| (e, c, g1) -> begin
(

let _59_1750 = (let _156_801 = (let _156_798 = (FStar_Syntax_Util.ml_comp FStar_TypeChecker_Common.t_unit r)
in Some (_156_798))
in (let _156_800 = (let _156_799 = (c.FStar_Syntax_Syntax.comp ())
in ((e), (_156_799)))
in (FStar_TypeChecker_TcTerm.check_expected_effect env _156_801 _156_800)))
in (match (_59_1750) with
| (e, _59_1748, g) -> begin
(

let _59_1751 = (let _156_802 = (FStar_TypeChecker_Rel.conj_guard g1 g)
in (FStar_TypeChecker_Rel.force_trivial_guard env _156_802))
in (

let se = FStar_Syntax_Syntax.Sig_main (((e), (r)))
in (

let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (((se)::[]), (env)))))
end))
end))))
end
| FStar_Syntax_Syntax.Sig_let (lbs, r, lids, quals) -> begin
(

let env = (FStar_TypeChecker_Env.set_range env r)
in (

let check_quals_eq = (fun l qopt q -> (match (qopt) with
| None -> begin
Some (q)
end
| Some (q') -> begin
if (((FStar_List.length q) = (FStar_List.length q')) && (FStar_List.forall2 FStar_Syntax_Util.qualifier_equal q q')) then begin
Some (q)
end else begin
(let _156_814 = (let _156_813 = (let _156_812 = (let _156_811 = (FStar_Syntax_Print.lid_to_string l)
in (let _156_810 = (FStar_Syntax_Print.quals_to_string q)
in (let _156_809 = (FStar_Syntax_Print.quals_to_string q')
in (FStar_Util.format3 "Inconsistent qualifier annotations on %s; Expected {%s}, got {%s}" _156_811 _156_810 _156_809))))
in ((_156_812), (r)))
in FStar_Syntax_Syntax.Error (_156_813))
in (Prims.raise _156_814))
end
end))
in (

let _59_1795 = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.fold_left (fun _59_1772 lb -> (match (_59_1772) with
| (gen, lbs, quals_opt) -> begin
(

let lbname = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (

let _59_1791 = (match ((FStar_TypeChecker_Env.try_lookup_val_decl env lbname.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)) with
| None -> begin
((gen), (lb), (quals_opt))
end
| Some ((uvs, tval), quals) -> begin
(

let quals_opt = (check_quals_eq lbname.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v quals_opt quals)
in (

let _59_1786 = (match (lb.FStar_Syntax_Syntax.lbtyp.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
()
end
| _59_1785 -> begin
(FStar_TypeChecker_Errors.warn r "Annotation from val declaration overrides inline type annotation")
end)
in (let _156_817 = (FStar_Syntax_Syntax.mk_lb ((FStar_Util.Inr (lbname)), (uvs), (FStar_Syntax_Const.effect_ALL_lid), (tval), (lb.FStar_Syntax_Syntax.lbdef)))
in ((false), (_156_817), (quals_opt)))))
end)
in (match (_59_1791) with
| (gen, lb, quals_opt) -> begin
((gen), ((lb)::lbs), (quals_opt))
end)))
end)) ((true), ([]), (if (quals = []) then begin
None
end else begin
Some (quals)
end))))
in (match (_59_1795) with
| (should_generalize, lbs', quals_opt) -> begin
(

let quals = (match (quals_opt) with
| None -> begin
(FStar_Syntax_Syntax.Visible_default)::[]
end
| Some (q) -> begin
if (FStar_All.pipe_right q (FStar_Util.for_some (fun _59_8 -> (match (_59_8) with
| (FStar_Syntax_Syntax.Irreducible) | (FStar_Syntax_Syntax.Visible_default) | (FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen) -> begin
true
end
| _59_1804 -> begin
false
end)))) then begin
q
end else begin
(FStar_Syntax_Syntax.Visible_default)::q
end
end)
in (

let lbs' = (FStar_List.rev lbs')
in (

let e = (let _156_821 = (let _156_820 = (let _156_819 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_unit)) None r)
in (((((Prims.fst lbs)), (lbs'))), (_156_819)))
in FStar_Syntax_Syntax.Tm_let (_156_820))
in (FStar_Syntax_Syntax.mk _156_821 None r))
in (

let _59_1838 = (match ((FStar_TypeChecker_TcTerm.tc_maybe_toplevel_term (

let _59_1808 = env
in {FStar_TypeChecker_Env.solver = _59_1808.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_1808.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_1808.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_1808.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_1808.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_1808.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_1808.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_1808.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_1808.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_1808.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_1808.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = should_generalize; FStar_TypeChecker_Env.letrecs = _59_1808.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = true; FStar_TypeChecker_Env.check_uvars = _59_1808.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_1808.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _59_1808.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _59_1808.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = _59_1808.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = _59_1808.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _59_1808.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_1808.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_1808.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = _59_1808.FStar_TypeChecker_Env.qname_and_index}) e)) with
| ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_let (lbs, e); FStar_Syntax_Syntax.tk = _59_1815; FStar_Syntax_Syntax.pos = _59_1813; FStar_Syntax_Syntax.vars = _59_1811}, _59_1822, g) when (FStar_TypeChecker_Rel.is_trivial g) -> begin
(

let quals = (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_meta (_59_1826, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Masked_effect)) -> begin
(FStar_Syntax_Syntax.HasMaskedEffect)::quals
end
| _59_1832 -> begin
quals
end)
in ((FStar_Syntax_Syntax.Sig_let (((lbs), (r), (lids), (quals)))), (lbs)))
end
| _59_1835 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_59_1838) with
| (se, lbs) -> begin
(

let _59_1844 = if (log env) then begin
(let _156_829 = (let _156_828 = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.map (fun lb -> (

let should_log = (match ((let _156_825 = (let _156_824 = (let _156_823 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in _156_823.FStar_Syntax_Syntax.fv_name)
in _156_824.FStar_Syntax_Syntax.v)
in (FStar_TypeChecker_Env.try_lookup_val_decl env _156_825))) with
| None -> begin
true
end
| _59_1842 -> begin
false
end)
in if should_log then begin
(let _156_827 = (FStar_Syntax_Print.lbname_to_string lb.FStar_Syntax_Syntax.lbname)
in (let _156_826 = (FStar_Syntax_Print.term_to_string lb.FStar_Syntax_Syntax.lbtyp)
in (FStar_Util.format2 "let %s : %s" _156_827 _156_826)))
end else begin
""
end))))
in (FStar_All.pipe_right _156_828 (FStar_String.concat "\n")))
in (FStar_Util.print1 "%s\n" _156_829))
end else begin
()
end
in (

let env = (FStar_TypeChecker_Env.push_sigelt env se)
in (((se)::[]), (env))))
end)))))
end))))
end))))


let for_export : FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.sigelt  ->  (FStar_Syntax_Syntax.sigelt Prims.list * FStar_Ident.lident Prims.list) = (fun hidden se -> (

let is_abstract = (fun quals -> (FStar_All.pipe_right quals (FStar_Util.for_some (fun _59_9 -> (match (_59_9) with
| FStar_Syntax_Syntax.Abstract -> begin
true
end
| _59_1854 -> begin
false
end)))))
in (

let is_hidden_proj_or_disc = (fun q -> (match (q) with
| (FStar_Syntax_Syntax.Projector (l, _)) | (FStar_Syntax_Syntax.Discriminator (l)) -> begin
(FStar_All.pipe_right hidden (FStar_Util.for_some (FStar_Ident.lid_equals l)))
end
| _59_1864 -> begin
false
end))
in (match (se) with
| FStar_Syntax_Syntax.Sig_pragma (_59_1866) -> begin
(([]), (hidden))
end
| (FStar_Syntax_Syntax.Sig_inductive_typ (_)) | (FStar_Syntax_Syntax.Sig_datacon (_)) -> begin
(FStar_All.failwith "Impossible")
end
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, _59_1877, r) -> begin
if (is_abstract quals) then begin
(FStar_List.fold_right (fun se _59_1884 -> (match (_59_1884) with
| (out, hidden) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (l, us, bs, t, _59_1890, _59_1892, quals, r) -> begin
(

let dec = (let _156_843 = (let _156_842 = (let _156_841 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Util.arrow bs _156_841))
in ((l), (us), (_156_842), ((FStar_Syntax_Syntax.Assumption)::(FStar_Syntax_Syntax.New)::quals), (r)))
in FStar_Syntax_Syntax.Sig_declare_typ (_156_843))
in (((dec)::out), (hidden)))
end
| FStar_Syntax_Syntax.Sig_datacon (l, us, t, _59_1902, _59_1904, _59_1906, _59_1908, r) -> begin
(

let dec = FStar_Syntax_Syntax.Sig_declare_typ (((l), (us), (t), ((FStar_Syntax_Syntax.Assumption)::[]), (r)))
in (((dec)::out), ((l)::hidden)))
end
| _59_1914 -> begin
((out), (hidden))
end)
end)) ses (([]), (hidden)))
end else begin
(((se)::[]), (hidden))
end
end
| FStar_Syntax_Syntax.Sig_assume (_59_1916, _59_1918, quals, _59_1921) -> begin
if (is_abstract quals) then begin
(([]), (hidden))
end else begin
(((se)::[]), (hidden))
end
end
| FStar_Syntax_Syntax.Sig_declare_typ (l, us, t, quals, r) -> begin
if (FStar_All.pipe_right quals (FStar_Util.for_some is_hidden_proj_or_disc)) then begin
(((FStar_Syntax_Syntax.Sig_declare_typ (((l), (us), (t), ((FStar_Syntax_Syntax.Assumption)::[]), (r))))::[]), ((l)::hidden))
end else begin
if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _59_10 -> (match (_59_10) with
| (FStar_Syntax_Syntax.Assumption) | (FStar_Syntax_Syntax.Projector (_)) | (FStar_Syntax_Syntax.Discriminator (_)) -> begin
true
end
| _59_1940 -> begin
false
end)))) then begin
(((se)::[]), (hidden))
end else begin
(([]), (hidden))
end
end
end
| FStar_Syntax_Syntax.Sig_main (_59_1942) -> begin
(([]), (hidden))
end
| (FStar_Syntax_Syntax.Sig_new_effect (_)) | (FStar_Syntax_Syntax.Sig_new_effect_for_free (_)) | (FStar_Syntax_Syntax.Sig_sub_effect (_)) | (FStar_Syntax_Syntax.Sig_effect_abbrev (_)) -> begin
(((se)::[]), (hidden))
end
| FStar_Syntax_Syntax.Sig_let ((false, (lb)::[]), _59_1961, _59_1963, quals) when (FStar_All.pipe_right quals (FStar_Util.for_some is_hidden_proj_or_disc)) -> begin
(

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (

let lid = fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v
in if (FStar_All.pipe_right hidden (FStar_Util.for_some (FStar_Syntax_Syntax.fv_eq_lid fv))) then begin
(([]), (hidden))
end else begin
(

let dec = FStar_Syntax_Syntax.Sig_declare_typ (((fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v), (lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp), ((FStar_Syntax_Syntax.Assumption)::[]), ((FStar_Ident.range_of_lid lid))))
in (((dec)::[]), ((lid)::hidden)))
end))
end
| FStar_Syntax_Syntax.Sig_let (lbs, r, l, quals) -> begin
if (is_abstract quals) then begin
(let _156_850 = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.map (fun lb -> (let _156_849 = (let _156_848 = (let _156_847 = (let _156_846 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in _156_846.FStar_Syntax_Syntax.fv_name)
in _156_847.FStar_Syntax_Syntax.v)
in ((_156_848), (lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp), ((FStar_Syntax_Syntax.Assumption)::quals), (r)))
in FStar_Syntax_Syntax.Sig_declare_typ (_156_849)))))
in ((_156_850), (hidden)))
end else begin
(((se)::[]), (hidden))
end
end))))


let tc_decls : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  (FStar_Syntax_Syntax.sigelt Prims.list * FStar_Syntax_Syntax.sigelt Prims.list * FStar_TypeChecker_Env.env) = (fun env ses -> (

let process_one_decl = (fun _59_1984 se -> (match (_59_1984) with
| (ses, exports, env, hidden) -> begin
(

let _59_1986 = if (FStar_TypeChecker_Env.debug env FStar_Options.Low) then begin
(let _156_859 = (FStar_Syntax_Print.sigelt_to_string se)
in (FStar_Util.print1 ">>>>>>>>>>>>>>Checking top-level decl %s\n" _156_859))
end else begin
()
end
in (

let _59_1990 = (tc_decl env se)
in (match (_59_1990) with
| (ses', env) -> begin
(

let _59_1993 = if ((FStar_Options.log_types ()) || (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("LogTypes")))) then begin
(let _156_864 = (FStar_List.fold_left (fun s se -> (let _156_863 = (let _156_862 = (FStar_Syntax_Print.sigelt_to_string se)
in (Prims.strcat _156_862 "\n"))
in (Prims.strcat s _156_863))) "" ses')
in (FStar_Util.print1 "Checked: %s\n" _156_864))
end else begin
()
end
in (

let _59_1996 = (FStar_List.iter (fun se -> (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.encode_sig env se)) ses')
in (

let _59_2005 = (FStar_List.fold_left (fun _59_2000 se -> (match (_59_2000) with
| (le, lh) -> begin
(

let tup = (for_export hidden se)
in (((FStar_List.rev_append (Prims.fst tup) le)), ((FStar_List.rev_append (Prims.snd tup) lh))))
end)) (([]), ([])) ses')
in (match (_59_2005) with
| (exported, hidden) -> begin
(((FStar_List.rev_append ses' ses)), (((FStar_List.rev_append exported []))::exports), (env), (hidden))
end))))
end)))
end))
in (

let _59_2031 = (FStar_List.fold_left (fun acc se -> (match (se) with
| FStar_Syntax_Syntax.Sig_new_effect_for_free (ne, r) -> begin
(

let _59_2019 = acc
in (match (_59_2019) with
| (_59_2013, _59_2015, env, _59_2018) -> begin
(

let _59_2022 = (cps_and_elaborate env ne)
in (match (_59_2022) with
| (ses, ne) -> begin
(

let ses = (FStar_List.append ses ((FStar_Syntax_Syntax.Sig_new_effect (((ne), (r))))::[]))
in (FStar_List.fold_left process_one_decl acc ses))
end))
end))
end
| _59_2025 -> begin
(process_one_decl acc se)
end)) (([]), ([]), (env), ([])) ses)
in (match (_59_2031) with
| (ses, exports, env, _59_2030) -> begin
(let _156_870 = (FStar_All.pipe_right (FStar_List.rev_append exports []) FStar_List.flatten)
in (((FStar_List.rev_append ses [])), (_156_870), (env)))
end))))


let tc_partial_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  (FStar_Syntax_Syntax.modul * FStar_Syntax_Syntax.sigelt Prims.list * FStar_TypeChecker_Env.env) = (fun env modul -> (

let name = (FStar_Util.format2 "%s %s" (if modul.FStar_Syntax_Syntax.is_interface then begin
"interface"
end else begin
"module"
end) modul.FStar_Syntax_Syntax.name.FStar_Ident.str)
in (

let msg = (Prims.strcat "Internals for " name)
in (

let env = (

let _59_2036 = env
in (let _156_875 = (not ((FStar_Options.should_verify modul.FStar_Syntax_Syntax.name.FStar_Ident.str)))
in {FStar_TypeChecker_Env.solver = _59_2036.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_2036.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_2036.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_2036.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_2036.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_2036.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_2036.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_2036.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_2036.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_2036.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_2036.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _59_2036.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _59_2036.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _59_2036.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _59_2036.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_2036.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = modul.FStar_Syntax_Syntax.is_interface; FStar_TypeChecker_Env.admit = _156_875; FStar_TypeChecker_Env.lax = _59_2036.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = _59_2036.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _59_2036.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_2036.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_2036.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = _59_2036.FStar_TypeChecker_Env.qname_and_index}))
in (

let _59_2039 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.push msg)
in (

let env = (FStar_TypeChecker_Env.set_current_module env modul.FStar_Syntax_Syntax.name)
in (

let _59_2045 = (tc_decls env modul.FStar_Syntax_Syntax.declarations)
in (match (_59_2045) with
| (ses, exports, env) -> begin
(((

let _59_2046 = modul
in {FStar_Syntax_Syntax.name = _59_2046.FStar_Syntax_Syntax.name; FStar_Syntax_Syntax.declarations = ses; FStar_Syntax_Syntax.exports = _59_2046.FStar_Syntax_Syntax.exports; FStar_Syntax_Syntax.is_interface = _59_2046.FStar_Syntax_Syntax.is_interface})), (exports), (env))
end))))))))


let tc_more_partial_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  (FStar_Syntax_Syntax.modul * FStar_Syntax_Syntax.sigelt Prims.list * FStar_TypeChecker_Env.env) = (fun env modul decls -> (

let _59_2054 = (tc_decls env decls)
in (match (_59_2054) with
| (ses, exports, env) -> begin
(

let modul = (

let _59_2055 = modul
in {FStar_Syntax_Syntax.name = _59_2055.FStar_Syntax_Syntax.name; FStar_Syntax_Syntax.declarations = (FStar_List.append modul.FStar_Syntax_Syntax.declarations ses); FStar_Syntax_Syntax.exports = _59_2055.FStar_Syntax_Syntax.exports; FStar_Syntax_Syntax.is_interface = _59_2055.FStar_Syntax_Syntax.is_interface})
in ((modul), (exports), (env)))
end)))


let check_exports : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  Prims.unit = (fun env modul exports -> (

let env = (

let _59_2061 = env
in {FStar_TypeChecker_Env.solver = _59_2061.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _59_2061.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _59_2061.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _59_2061.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _59_2061.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _59_2061.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _59_2061.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _59_2061.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _59_2061.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _59_2061.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _59_2061.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _59_2061.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _59_2061.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = true; FStar_TypeChecker_Env.check_uvars = _59_2061.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _59_2061.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _59_2061.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _59_2061.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = true; FStar_TypeChecker_Env.lax_universes = true; FStar_TypeChecker_Env.type_of = _59_2061.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _59_2061.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _59_2061.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = _59_2061.FStar_TypeChecker_Env.qname_and_index})
in (

let check_term = (fun lid univs t -> (

let _59_2070 = (FStar_Syntax_Subst.open_univ_vars univs t)
in (match (_59_2070) with
| (univs, t) -> begin
(

let _59_2072 = if (let _156_895 = (let _156_894 = (FStar_TypeChecker_Env.set_current_module env modul.FStar_Syntax_Syntax.name)
in (FStar_TypeChecker_Env.debug _156_894))
in (FStar_All.pipe_left _156_895 (FStar_Options.Other ("Exports")))) then begin
(let _156_900 = (FStar_Syntax_Print.lid_to_string lid)
in (let _156_899 = (let _156_897 = (FStar_All.pipe_right univs (FStar_List.map (fun x -> (FStar_Syntax_Print.univ_to_string (FStar_Syntax_Syntax.U_name (x))))))
in (FStar_All.pipe_right _156_897 (FStar_String.concat ", ")))
in (let _156_898 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print3 "Checking for export %s <%s> : %s\n" _156_900 _156_899 _156_898))))
end else begin
()
end
in (

let env = (FStar_TypeChecker_Env.push_univ_vars env univs)
in (let _156_901 = (FStar_TypeChecker_TcTerm.tc_trivial_guard env t)
in (FStar_All.pipe_right _156_901 Prims.ignore))))
end)))
in (

let check_term = (fun lid univs t -> (

let _59_2079 = (let _156_910 = (let _156_909 = (FStar_Syntax_Print.lid_to_string modul.FStar_Syntax_Syntax.name)
in (let _156_908 = (FStar_Syntax_Print.lid_to_string lid)
in (FStar_Util.format2 "Interface of %s violates its abstraction (add a \'private\' qualifier to \'%s\'?)" _156_909 _156_908)))
in (FStar_TypeChecker_Errors.message_prefix.FStar_TypeChecker_Errors.set_prefix _156_910))
in (

let _59_2081 = (check_term lid univs t)
in (FStar_TypeChecker_Errors.message_prefix.FStar_TypeChecker_Errors.clear_prefix ()))))
in (

let rec check_sigelt = (fun _59_11 -> (match (_59_11) with
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, _59_2088, _59_2090) -> begin
if (not ((FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Private)))) then begin
(FStar_All.pipe_right ses (FStar_List.iter check_sigelt))
end else begin
()
end
end
| FStar_Syntax_Syntax.Sig_inductive_typ (l, univs, binders, typ, _59_2098, _59_2100, _59_2102, r) -> begin
(

let t = (let _156_915 = (let _156_914 = (let _156_913 = (FStar_Syntax_Syntax.mk_Total typ)
in ((binders), (_156_913)))
in FStar_Syntax_Syntax.Tm_arrow (_156_914))
in (FStar_Syntax_Syntax.mk _156_915 None r))
in (check_term l univs t))
end
| FStar_Syntax_Syntax.Sig_datacon (l, univs, t, _59_2111, _59_2113, _59_2115, _59_2117, _59_2119) -> begin
(check_term l univs t)
end
| FStar_Syntax_Syntax.Sig_declare_typ (l, univs, t, quals, _59_2127) -> begin
if (not ((FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Private)))) then begin
(check_term l univs t)
end else begin
()
end
end
| FStar_Syntax_Syntax.Sig_let ((_59_2131, lbs), _59_2135, _59_2137, quals) -> begin
if (not ((FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Private)))) then begin
(FStar_All.pipe_right lbs (FStar_List.iter (fun lb -> (

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (check_term fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v lb.FStar_Syntax_Syntax.lbunivs lb.FStar_Syntax_Syntax.lbtyp)))))
end else begin
()
end
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (l, univs, binders, comp, quals, r) -> begin
if (not ((FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Private)))) then begin
(

let arrow = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow (((binders), (comp)))) None r)
in (check_term l univs arrow))
end else begin
()
end
end
| (FStar_Syntax_Syntax.Sig_main (_)) | (FStar_Syntax_Syntax.Sig_assume (_)) | (FStar_Syntax_Syntax.Sig_new_effect (_)) | (FStar_Syntax_Syntax.Sig_new_effect_for_free (_)) | (FStar_Syntax_Syntax.Sig_sub_effect (_)) | (FStar_Syntax_Syntax.Sig_pragma (_)) -> begin
()
end))
in if (FStar_Ident.lid_equals modul.FStar_Syntax_Syntax.name FStar_Syntax_Const.prims_lid) then begin
()
end else begin
(FStar_List.iter check_sigelt exports)
end)))))


let finish_partial_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  FStar_Syntax_Syntax.sigelts  ->  (FStar_Syntax_Syntax.modul * FStar_TypeChecker_Env.env) = (fun env modul exports -> (

let modul = (

let _59_2173 = modul
in {FStar_Syntax_Syntax.name = _59_2173.FStar_Syntax_Syntax.name; FStar_Syntax_Syntax.declarations = _59_2173.FStar_Syntax_Syntax.declarations; FStar_Syntax_Syntax.exports = exports; FStar_Syntax_Syntax.is_interface = modul.FStar_Syntax_Syntax.is_interface})
in (

let env = (FStar_TypeChecker_Env.finish_module env modul)
in (

let _59_2177 = (check_exports env modul exports)
in (

let _59_2179 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.pop (Prims.strcat "Ending modul " modul.FStar_Syntax_Syntax.name.FStar_Ident.str))
in (

let _59_2181 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.encode_modul env modul)
in (

let _59_2183 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.refresh ())
in (

let _59_2185 = (let _156_923 = (FStar_Options.restore_cmd_line_options true)
in (FStar_All.pipe_right _156_923 Prims.ignore))
in ((modul), (env))))))))))


let tc_modul : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  (FStar_Syntax_Syntax.modul * FStar_TypeChecker_Env.env) = (fun env modul -> (

let _59_2192 = (tc_partial_modul env modul)
in (match (_59_2192) with
| (modul, non_private_decls, env) -> begin
(finish_partial_modul env modul non_private_decls)
end)))


let check_module : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.modul  ->  (FStar_Syntax_Syntax.modul * FStar_TypeChecker_Env.env) = (fun env m -> (

let _59_2195 = if (FStar_Options.debug_any ()) then begin
(let _156_932 = (FStar_Syntax_Print.lid_to_string m.FStar_Syntax_Syntax.name)
in (FStar_Util.print2 "Checking %s: %s\n" (if m.FStar_Syntax_Syntax.is_interface then begin
"i\'face"
end else begin
"module"
end) _156_932))
end else begin
()
end
in (

let _59_2199 = (tc_modul env m)
in (match (_59_2199) with
| (m, env) -> begin
(

let _59_2200 = if (FStar_Options.dump_module m.FStar_Syntax_Syntax.name.FStar_Ident.str) then begin
(let _156_933 = (FStar_Syntax_Print.modul_to_string m)
in (FStar_Util.print1 "%s\n" _156_933))
end else begin
()
end
in ((m), (env)))
end))))




