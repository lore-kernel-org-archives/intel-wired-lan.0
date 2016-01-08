From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Fri, 8 Jan 2016 20:51:40 +0000
Subject: [Intel-wired-lan] net-i40e: Reconsider further usage of
 variable "i" in i40e_vc_get_vf_resources_msg()
In-Reply-To: <5686925F.5020508@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <56868E0B.5040602@users.sourceforge.net>
 <5686925F.5020508@users.sourceforge.net>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AFE3115@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: SF Markus Elfring [mailto:elfring at users.sourceforge.net]
> 
> Hello,
> 
> I have taken another look at the implementation of the
> function "i40e_vc_get_vf_resources_msg". I find the use of the variable
> "i"
> strange there. It seems that the value from the increment operation in
> an
> if branch is not reused so far.
> 
> I would appreciate a further clarification.
> Can this variable be eventually deleted?

Thanks for pointing this out.  We've got an internal patch coming that will address this.

Cheers,
sln
