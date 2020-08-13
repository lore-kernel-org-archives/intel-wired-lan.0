From: Stefan Assmann <sassmann@kpanic.de>
Date: Thu, 13 Aug 2020 07:28:07 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: fix uninitialized variable in
 i40e_set_vsi_promisc
In-Reply-To: <20200812104628.340a073a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200812143950.11675-1-sassmann@kpanic.de>
 <20200812104628.340a073a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <282db652-e9a7-d7be-1f9d-9434c11323d4@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12.08.20 19:46, Jakub Kicinski wrote:
> On Wed, 12 Aug 2020 16:39:50 +0200 Stefan Assmann wrote:
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function ?i40e_set_vsi_promisc?:
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1176:14: error: ?aq_ret? may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>   i40e_status aq_ret;
> 
> What's your compiler? I don't see it on GCC 10.1.

gcc version 8.3.1 20191121 (Red Hat 8.3.1-5) (GCC)

>> In case the code inside the if statement and the for loop does not get
>> executed aq_ret will be uninitialized when the variable gets returned at
>> the end of the function.
> 
> I think it'd be a better fix to make num_vlans unsigned.

Agreed, I'll send a v2 patch later.
Thanks for the review Jakub!

  Stefan
