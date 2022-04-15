From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 15 Apr 2022 18:31:51 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <20220415183845.51a326fe@ceranb>
References: <20220413072259.3189386-1-ivecera@redhat.com>
 <YlldFriBVkKEgbBs@boxer> <20220415183845.51a326fe@ceranb>
Message-ID: <CO1PR11MB5089695CB3733F4B1284E3CED6EE9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Ivan Vecera <ivecera@redhat.com>
> Sent: Friday, April 15, 2022 9:39 AM
> To: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Cc: netdev at vger.kernel.org; Fei Liu <feliu@redhat.com>; moderated list:INTEL
> ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; mschmidt
> <mschmidt@redhat.com>; Brett Creeley <brett.creeley@intel.com>; open list
> <linux-kernel@vger.kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by cfg_lock in
> ice_vc_process_vf_msg()
> 
> On Fri, 15 Apr 2022 13:55:02 +0200
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > On Wed, Apr 13, 2022 at 09:22:59AM +0200, Ivan Vecera wrote:
> > > Previous patch labelled "ice: Fix incorrect locking in
> > > ice_vc_process_vf_msg()"  fixed an issue with ignored messages
> >
> > tiny tiny nit: double space after "
> > Also, has mentioned patch landed onto some tree so that we could provide
> > SHA-1 of it? If not, then maybe squashing this one with the mentioned one
> > would make sense?
> 
> Well, that commit were already tested and now it is present in Tony's queue
> but not in upstream yet. It is not problem to squash together but the first
> was about ignored VF messages and this one is about race and I didn't want
> to make single patch with huge description that cover both issues.
> But as I said, no problem to squash if needed.
> 
> Thx,
> Ivan

I'm fine with either squashing or keeping them as separate changes.
