From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 30 Oct 2015 14:36:45 -0400
Subject: [Intel-wired-lan] [PATCH v3 net] i40e: Look up MAC address in
 Open Firmware or IDPROM
In-Reply-To: <FC41C24E35F18A40888AACA1A36F3E418AFACA14@fmsmsx115.amr.corp.intel.com>
References: <20151030150344.GG9312@oracle.com>
 <FC41C24E35F18A40888AACA1A36F3E418AFACA14@fmsmsx115.amr.corp.intel.com>
Message-ID: <20151030183645.GD32759@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (10/30/15 18:28), Nelson, Shannon wrote:
> 
> Going along with this being the equivalent of the ixgbe patch, I'd
> prefer the new code to be in i40e_main.c, rather than in i40e_common.c.
> In the design of our drivers, the common file is essentially a device
> specific layer, and the OS and platform related stuff should stay in
> i40e_main.c.  That would also take care of one of the include file nits
> that Andy mentioned.

ok, and that was my initial instinct as well, except that I noticed
that the existing i40e code tries interesting variations from the 
typical intel driver model by calling i40e_get_mac_addr() which lives in
(for reasons not obvious to me) i40e_common.c

So I assumed there must be some other deeper wisdom at work here.

> At the risk of flying my Device Tree ignorance for all to see, I have
> a couple questions on how this is used.
> 
> Since the mac address is specific to the individual device, how does it
> get into the device tree?  I thought the device tree was compiled ahead
> of time for the platform it is used on.  Is this a generic DT pattern
> just in case some platform actually has the mac-address?  Or does the
> device mac-address get saved into the DT on the first time through this
> path so it can be found next time?
> 
> If the Device Tree has a different mac address than the HW, when
> does the kernel tell the HW to use a different mac address?  Does the
> DT management eventually call the ndo_set_mac_address call so the HW
> knows to use a different mac address?

yes, and here I was hoping for some feedback from the intel folks as
well. Commit c762dff24c06 sets hw->mac.perm_addr. I dont know
if there is some similar i40e state that needs to be set.

Please share insights.

--Sowmini

