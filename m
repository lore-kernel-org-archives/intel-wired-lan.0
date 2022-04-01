From: Ivan Vecera <ivecera@redhat.com>
Date: Fri, 1 Apr 2022 10:47:30 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Fix incorrect locking in
 ice_vc_process_vf_msg()
In-Reply-To: <CO1PR11MB5089888D13802251F6830A8ED6E19@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220331105005.2580771-1-ivecera@redhat.com>
 <YkWpNVXYEBo/u3dm@boxer> <YkWp5JJ9Sp6UCTw7@boxer>
 <CAFWUkrTzE87bduD431nu11biHi78XFitUWQfiwcU6_4UPU9FBg@mail.gmail.com>
 <CO1PR11MB5089888D13802251F6830A8ED6E19@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <20220401104730.44cd443e@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 31 Mar 2022 19:59:11 +0000
"Keller, Jacob E" <jacob.e.keller@intel.com> wrote:

> > -----Original Message-----
> > From: Brett Creeley <brett@pensando.io>
> > Sent: Thursday, March 31, 2022 9:33 AM
> > To: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Cc: ivecera <ivecera@redhat.com>; netdev at vger.kernel.org; moderated
> > list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; mschmidt
> > <mschmidt@redhat.com>; open list <linux-kernel@vger.kernel.org>; poros
> > <poros@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Keller, Jacob E
> > <jacob.e.keller@intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix incorrect locking in
> > ice_vc_process_vf_msg()
> > 
> > On Thu, Mar 31, 2022 at 6:17 AM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:  
> > >
> > > On Thu, Mar 31, 2022 at 03:14:32PM +0200, Maciej Fijalkowski wrote:  
> > > > On Thu, Mar 31, 2022 at 12:50:04PM +0200, Ivan Vecera wrote:  
> > > > > Usage of mutex_trylock() in ice_vc_process_vf_msg() is incorrect
> > > > > because message sent from VF is ignored and never processed.
> > > > >
> > > > > Use mutex_lock() instead to fix the issue. It is safe because this  
> > > >
> > > > We need to know what is *the* issue in the first place.
> > > > Could you please provide more context what is being fixed to the readers
> > > > that don't have an access to bugzilla?
> > > >
> > > > Specifically, what is the case that ignoring a particular message when
> > > > mutex is already held is a broken behavior?  
> > >
> > > Uh oh, let's
> > > CC: Brett Creeley <brett@pensando.io>  
> >  
> 
> Thanks for responding, Brett! :)
>  
> > My concern here is that we don't want to handle messages
> > from the context of the "previous" VF configuration if that
> > makes sense.
> >   
> 
> Makes sense. Perhaps we need to do some sort of "clear the existing message queue" when we initiate a reset?

I think this logic is already there... Function ice_reset_vf() (running under cfg_lock) sets default allowlist
during reset (these are VIRTCHNL_OP_GET_VF_RESOURCES, VIRTCHNL_OP_VERSION, VIRTCHNL_OP_RESET_VF).
Function ice_vc_process_vf_msg() currently processed message whether is allowed or not so any spurious messages
there were sent by VF prior reset should be dropped already.

> 
> > It might be best to grab the cfg_lock before doing any
> > message/VF validating in ice_vc_process_vf_msg() to
> > make sure all of the checks are done under the cfg_lock.
> >   
> 
> Yes that seems like it should be done.

Yes, the mutex should be placed prior ice_vc_is_opcode_allowed() call to serialize accesses to allowlist.
Will send v2.

Thanks,
Ivan

