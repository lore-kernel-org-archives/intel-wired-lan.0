From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 17 Feb 2022 17:24:56 +0000
Subject: [Intel-wired-lan] [net PATCH 2/2] ice: stop disabling VFs due
 to PF error responses
In-Reply-To: <20220217005136.75627-3-jacob.e.keller@intel.com>
References: <20220217005136.75627-1-jacob.e.keller@intel.com>
 <20220217005136.75627-3-jacob.e.keller@intel.com>
Message-ID: <043ae533aa1225387da24e35578da76029be08cd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2022-02-16 at 16:51 -0800, Jacob Keller wrote:
> The ice_vc_send_msg_to_vf function has logic to detect "failure"
> responses being sent to a VF. If a VF is sent more than
> ICE_DFLT_NUM_INVAL_MSGS_ALLOWED then the VF is marked as disabled.
> Almost identical logic also existed in the i40e driver.
> 
> This logic was added to the ice driver in commit 1071a8358a28 ("ice:
> Implement virtchnl commands for AVF support") which itself copied
> from
> the i40e implementation in commit 5c3c48ac6bf5 ("i40e: implement
> virtual
> device interface").
> 
> Neither commit provides a proper explanation or justification of the
> check. In fact, later commits to i40e changed the logic to allow
> bypassing the check in some specific instances.
> 
> The "logic" for this seems to be that error responses somehow
> indicate a
> malicious VF. This is not really true. The PF might be sending an
> error
> for any number of reasons such as lack of resources, etc.
> 
> Additionally, this causes the PF to log an info message for every
> failed
> VF response which may confuse users, and can spam the kernel log.
> 
> This behavior is not documented as part of any requirement for our
> products and other operating system drivers such as the FreeBSD
> implementation of our drivers do not include this type of check.
> 
> In fact, the change from dev_err to dev_info in i40e commit
> 18b7af57d9c1
> ("i40e: Lower some message levels") explains that these messages
> typically don't actually indicate a real issue. It is quite likely
> that
> a user who hits this in practice will be very confused as the VF will
> be
> disabled without an obvious way to recover.
> 
> We already have robust malicious driver detection logic using actual
> hardware detection mechanisms that detect and prevent invalid device
> usage. Remove the logic since its not a documented requirement and
> the
> behavior is not intuitive.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

If this is for net, it should have a Fixes: as well.

Thanks,
Tony

