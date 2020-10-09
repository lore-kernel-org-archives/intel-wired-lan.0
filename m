From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 9 Oct 2020 16:35:35 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: ice: Use uintptr_t for
 casting data
In-Reply-To: <20201009061827.1279-1-shipujin.t@gmail.com>
References: <20201009061827.1279-1-shipujin.t@gmail.com>
Message-ID: <0e4c5d21c237afb5feb297b10d63550a15868ded.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2020-10-09 at 14:18 +0800, Pujin Shi wrote:
> Fix up a compiler error on 64bit architectures where pointers.
> 
> In file included from
> drivers/net/ethernet/intel/ice/ice_flex_pipe.c:6:0:
> drivers/net/ethernet/intel/ice/ice_flex_pipe.c: In function
> 'ice_free_flow_profs':
> drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning: cast from
> pointer to integer of different size [-Wpointer-to-int-cast]
>  #define ICE_FLOW_ENTRY_HNDL(e) ((u64)e)
>                                  ^
> drivers/net/ethernet/intel/ice/ice_flex_pipe.c:2882:9: note: in
> expansion of macro 'ICE_FLOW_ENTRY_HNDL'
>          ICE_FLOW_ENTRY_HNDL(e));
>          ^
> In file included from drivers/net/ethernet/intel/ice/ice_flow.c:5:0:
> drivers/net/ethernet/intel/ice/ice_flow.c: In function
> 'ice_flow_add_entry':
> drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning: cast from
> pointer to integer of different size [-Wpointer-to-int-cast]
>  #define ICE_FLOW_ENTRY_HNDL(e) ((u64)e)
>                                  ^
> drivers/net/ethernet/intel/ice/ice_flow.c:946:13: note: in expansion
> of macro 'ICE_FLOW_ENTRY_HNDL'
>   *entry_h = ICE_FLOW_ENTRY_HNDL(e);
>              ^
> 
> 2 warnings generated
> 
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

Thanks for the patch Pujin, however, Bixuan Cui has already submitted a
patch to resolve this issue [1].

[1] 
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/85dcea48-8b82-d806-0026-e6b371e6a092 at huawei.com/

Thanks,
Tony
