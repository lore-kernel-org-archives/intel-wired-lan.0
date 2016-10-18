From: David Ahern <dsa@cumulusnetworks.com>
Date: Mon, 17 Oct 2016 18:42:14 -0600
Subject: [Intel-wired-lan] [PATCH net-next 02/11] net: Introduce new api
 for walking upper and lower devices
In-Reply-To: <20161017052121.2322279d@xeon-e3>
References: <1476494931-31813-1-git-send-email-dsa@cumulusnetworks.com>
 <1476494931-31813-3-git-send-email-dsa@cumulusnetworks.com>
 <20161017052121.2322279d@xeon-e3>
Message-ID: <f2eee17c-835c-b14e-6c96-4fd8fb7d18c9@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/17/16 6:21 AM, Stephen Hemminger wrote:
> 
> No if/else needed. No cast of void * ptr need. Use const if possible?
> 

so much of the stack does not use const and trying to add it for this API does not work -- the upper or lower device is passed to the callbacks and those callbacks invoke other apis. e.g., the bond patch calls vlan_get_encap_level, bond_verify_device_path and bond_confirm_addr and none of those accept a const dev.

v3 coming up with the more succinct versions, but const is not possible.
