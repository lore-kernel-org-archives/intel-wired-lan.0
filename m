From: Shannon Nelson <sln@onemain.com>
Date: Fri, 17 Jun 2016 12:02:40 -0700
Subject: [Intel-wired-lan] [next PATCH S38 6/7] i40e: refactor rx filter
 handling
In-Reply-To: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D79927A7F@FMSMSX113.amr.corp.intel.com>
References: <1466034139-11828-1-git-send-email-bimmy.pujari@intel.com>
 <1466034139-11828-7-git-send-email-bimmy.pujari@intel.com>
 <57620EDD.2070407@onemain.com>
 <AAEA33E297BCAC4B9BB20A7C2DF0AB8D79927A7F@FMSMSX113.amr.corp.intel.com>
Message-ID: <57644950.6040705@onemain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/17/2016 08:53 AM, Williams, Mitch A wrote:
>>> From: Mitch Williams <mitch.a.williams@intel.com>
>>>
>>> Properly track filter adds and deletes so the driver doesn't lose filters
>>> during resets and up/down cycles. Add a tracking mechanism so that the
>>> driver knows when to enter and leave promiscuous mode.
>> Thanks, this was sorely needed.
> Yes, it was needed, but you should NOT CARE.

I care because I still want to use this driver as a high point on my 
resume :-).

[...]


>    struct i40e_mac_filter {
>    	struct list_head list;
>    	u8 macaddr[ETH_ALEN];
> @@ -456,8 +464,7 @@ struct i40e_mac_filter {
>    	u8 counter;		/* number of instances of this filter */
>    	bool is_vf;		/* filter belongs to a VF */
>    	bool is_netdev;		/* filter belongs to a netdev */
> -	bool changed;		/* filter needs to be sync'd to the HW */
> -	bool is_laa;		/* filter is a Locally Administered Address */
>> So you're dumping LAA support?  Or is this extra work no longer needed?
>> I would have expected some discussion of this in the commit notes.
> I'll update the commit message. It's currently looking like we don't need this code.

Perhaps you're using newer NVM?  Be sure to try it on an older NVM to 
see what happens to your LAA when you do a few different resets. I 
believe this code was specifically addressing an issue where the address 
register was getting reset on Global and Core resets.  See net-next 
commit 6252c7e4e from 2 years ago, which I believe references internal 
commit 6e643f9a59.

sln


