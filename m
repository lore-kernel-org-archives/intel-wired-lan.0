From: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 23 May 2022 07:40:27 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH] drivers/net/ethernet/intel: fix typos
 in comments
In-Reply-To: <71292e14-fe6c-f475-009d-1ea8cde0ea46@molgen.mpg.de>
References: <20220521111145.81697-50-Julia.Lawall@inria.fr>
 <71292e14-fe6c-f475-009d-1ea8cde0ea46@molgen.mpg.de>
Message-ID: <alpine.DEB.2.22.394.2205230736190.2777@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On Mon, 23 May 2022, Paul Menzel wrote:

> Dear Julia,
>
>
> Thank you for your patch.
>
> I noticed, that the maintainer Tony wasn?t in the Cc: list.

get_maintainer reports him as a "supporter", and I think that my script
only takes people listed as "maintainer".

> Am 21.05.22 um 13:11 schrieb Julia Lawall:
> > Spelling mistakes (triple letters) in comments.
> > Detected with the help of Coccinelle.
>
> I?d be interested in the script you used.

Attached.  It should have a pretty low rate of false positives.  Mostly
things like Eeew and Wheee.

>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
>
> Nit: One unneeded blank line.

OK, thanks.

julia

> > ---
> >   drivers/net/ethernet/intel/fm10k/fm10k_mbx.c   |    2 +-
> >   drivers/net/ethernet/intel/ice/ice_lib.c       |    2 +-
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
> > b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
> > index 30ca9ee1900b..f2fba6e1d0f7 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
> > @@ -1825,7 +1825,7 @@ static void fm10k_sm_mbx_process_error(struct
> > fm10k_mbx_info *mbx)
> >   		fm10k_sm_mbx_connect_reset(mbx);
> >   		break;
> >   	case FM10K_STATE_CONNECT:
> > -		/* try connnecting at lower version */
> > +		/* try connecting at lower version */
> >   		if (mbx->remote) {
> >   			while (mbx->local > 1)
> >   				mbx->local--;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 454e01ae09b9..70961c0343e7 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -2403,7 +2403,7 @@ static void ice_set_agg_vsi(struct ice_vsi *vsi)
> >   				agg_id);
> >   			return;
> >   		}
> > -		/* aggregator node is created, store the neeeded info */
> > +		/* aggregator node is created, store the needed info */
> >   		agg_node->valid = true;
> >   		agg_node->agg_id = agg_id;
> >   	}
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > index 3e74ab82868b..3f5ef5269bb2 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > @@ -77,7 +77,7 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter
> > *adapter,
> >   	IXGBE_WRITE_REG(hw, IXGBE_PFDTXGSWC, IXGBE_PFDTXGSWC_VT_LBEN);
> >   	adapter->bridge_mode = BRIDGE_MODE_VEB;
> >   -	/* limit trafffic classes based on VFs enabled */
> > +	/* limit traffic classes based on VFs enabled */
> >   	if ((adapter->hw.mac.type == ixgbe_mac_82599EB) && (num_vfs < 16)) {
> >   		adapter->dcb_cfg.num_tcs.pg_tcs = MAX_TRAFFIC_CLASS;
> >   		adapter->dcb_cfg.num_tcs.pfc_tcs = MAX_TRAFFIC_CLASS;
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
>
-------------- next part --------------
#spatch -j 44 --no-includes --include-headers --very-quiet

@initialize:ocaml@
@@

let seen = Hashtbl.create 101
let bseen = Hashtbl.create 101
let ids = Hashtbl.create 101
exception NotOK

let okw = ["needn";"aren";"isn";"wasn";"doesn";"didn";"weren";"shouldn";"couldn";"wouldn";"hasn";"haven";"linux";"hotplug";"cpu";"ifdef";"ifndef";"endif";"struct"]

let add i =
  (if not (Hashtbl.mem ids i) then Hashtbl.add ids i ());
  let pieces = Str.split (Str.regexp "_") i in
  List.iter
    (fun i -> if not (Hashtbl.mem ids i) then Hashtbl.add ids i ())
    pieces;
  false

let vowels = ['a';'e';'i';'o';'u';'y';'A';'E';'I';'O';'U';'Y']

let hasvowel s =
  try
    String.iter
      (fun c ->
	if List.mem c vowels
	then raise NotOK)
      s;
    false
  with NotOK -> true

let hasconsonant s =
  try
    String.iter
      (fun c ->
	if not(List.mem c vowels)
	then raise NotOK)
      s;
    false
  with NotOK -> true

let only_letters s =
  let islower c = 'a' <= c && c <= 'z' in
  let isupper c = 'A' <= c && c <= 'Z' in
  try
    String.iteri
      (fun i c ->
	let ok =
	  if i = 0
	  then islower c || isupper c
	  else islower c in
	if not ok
	then raise NotOK)
      s;
    true
  with NotOK -> false

let hasthree s =
  let l = Common.list_of_string s in
  let rec loop = function
      a::b::c::d::_ when a = b && b = c && c = d -> false
    | a::b::c::_ when a = b && b = c -> true
    | x::xs -> loop xs
    | [] -> false in
  loop l

let check bad loc p c =
  if not(Hashtbl.mem seen c)
  then
  begin
  Hashtbl.add seen c ();
  let pieces = Str.split (Str.regexp "\\b") c in
  List.iter
    (fun word ->
      if String.length word <= 3 || not(only_letters word) || Hashtbl.mem ids word || not(hasvowel word) || not(hasconsonant word)
      then ()
      else
	let word = String.uncapitalize_ascii word in
	if List.mem word okw
	then ()
	else
	let res =
	  if hasthree word then [word] else [] in
	List.iter
	  (fun wd ->
	    Common.hashadd bseen word (loc,word,p))
	  res)
    pieces
  end

@identifier@
identifier i : script:ocaml() { add i };
@@
i

@r1@
comments c;
statement S;
position p;
@@

S at c@p

@script:ocaml@
c << r1.c;
p << r1.p;
@@

let bad = ref [] in
List.iter
(function c->
let (cb,ci,ca) = c in
List.iter (check bad "before" p) cb;
List.iter (check bad "within" p) ci;
List.iter (check bad "after" p) ca)
c

@r2@
comments c;
declaration d;
position p;
@@

d at c@p

@script:ocaml@
c << r2.c;
p << r2.p;
@@

let bad = ref [] in
List.iter
(function c->
let (cb,ci,ca) = c in
List.iter (check bad "before" p) cb;
List.iter (check bad "within" p) ci;
List.iter (check bad "after" p) ca)
c

@finalize:ocaml@
bseen << merge.bseen;
@@

List.iter
  (fun bseen ->
    Hashtbl.iter
      (fun word l ->
	match !l with
	  [(loc,word,p)] ->
	    Coccilib.print_main
	      (Printf.sprintf "problem with %s comment word: %s" loc word)
	      p
	| _ -> ())
      bseen)
  bseen
