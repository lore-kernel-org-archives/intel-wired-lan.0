From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Thu, 7 Jan 2016 22:43:20 +0000
Subject: [Intel-wired-lan] [PATCH] net-i40e: Replace variable
 initialisations by assignments in i40e_vc_get_vf_resources_msg()
In-Reply-To: <56868E0B.5040602@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <56868E0B.5040602@users.sourceforge.net>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AFE2AAD@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: SF Markus Elfring [mailto:elfring at users.sourceforge.net]
> Sent: Friday, January 01, 2016 6:33 AM
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Jan 2016 15:11:09 +0100
> 
> Replace explicit initialisations for four local variables at the beginning
> by assignments that will only be performed if the corresponding code
> will really be executed.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

This seems to me to be unnecessary fussing with the code.

sln

