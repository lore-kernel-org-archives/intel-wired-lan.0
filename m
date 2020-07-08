From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 8 Jul 2020 16:48:12 -0700
Subject: [Intel-wired-lan] [net-next,
 v7 5/5] ice: add switch rule management for DCF
In-Reply-To: <eca3253391dd34a267e607dbd847d6878bc3a6fe.camel@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200701012557.40234-1-haiyue.wang@intel.com>
 <20200701012557.40234-6-haiyue.wang@intel.com>
 <eca3253391dd34a267e607dbd847d6878bc3a6fe.camel@intel.com>
Message-ID: <20200708164812.384ae8ea@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 8 Jul 2020 22:55:21 +0000 Nguyen, Anthony L wrote:
> > @@ -490,7 +476,7 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16
> > *vsi_list_id,
> >   *
> >   * Add(0x02a0)/Update(0x02a1)/Remove(0x02a2) switch rules commands
> > to firmware
> >   */
> > -static enum ice_status
> > +enum ice_status
> >  ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16
> > rule_list_sz,
> >  		u8 num_rules, enum ice_adminq_opc opc, struct ice_sq_cd
> > *cd)
> >  {  
> 
> Hi Dave, Jakub,
> 
> This feature is only built when CONFIG_PCI_IOV is set. We end up with
> this namespace issue using defconfig when checked against namespace.pl
> since CONFIG_PCI_IOV is not enabled.
> 	Externally defined symbols with no external references
>           ice_switch.o
>             ice_aq_sw_rules
> 
> From a previous patch, neither of you liked the use of CONFIG_ to
> control static-ness. I wanted to check that you are ok with the
> namespace issue or if you have a preferred method to resolve this
> issue. I appreciate your feedback.

IMHO that should be fine. I'd only trust namespace.pl on a all*config
kernel, if at all.
