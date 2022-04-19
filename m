From: Ivan Vecera <ivecera@redhat.com>
Date: Tue, 19 Apr 2022 16:23:02 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <607248b2-bfb2-08a2-3d17-67c5c28840fc@intel.com>
References: <20220413072259.3189386-1-ivecera@redhat.com>
 <YlldFriBVkKEgbBs@boxer> <YlldsfrRJURXpp5d@boxer>
 <248da3d7-cb00-14b6-12f0-6bb9fda6d532@intel.com>
 <20220416133043.08b4ee74@ceranb>
 <607248b2-bfb2-08a2-3d17-67c5c28840fc@intel.com>
Message-ID: <20220419162302.60378ede@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 Apr 2022 11:10:30 -0700
Tony Nguyen <anthony.l.nguyen@intel.com> wrote:

> > If you want to leave the code as is and remove this from the patch
> > let me know and I will send v2.  
> 
> The change itself looks ok to me, but for net patches, we should fix the 
> issue without introducing other changes. A v2 without this change would 
> be great; feel free to submit this change to -next after I've applied 
> the v2 for this patch.
> 
> Thanks,
> 
> Tony
Agree, sending v2.

Thanks,
Ivan

