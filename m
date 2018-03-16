From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 16 Mar 2018 09:21:20 -0700
Subject: [Intel-wired-lan] [PATCH v2 04/15] ice: Get switch config,
 scheduler config and device capabilities
In-Reply-To: <20180315234802.31336-5-anirudh.venkataramanan@intel.com>
References: <20180315234802.31336-1-anirudh.venkataramanan@intel.com>
 <20180315234802.31336-5-anirudh.venkataramanan@intel.com>
Message-ID: <b6d78fc5-a145-45ef-7367-a0783d1a4310@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/15/2018 4:47 PM, Anirudh Venkataramanan wrote:
> This patch adds to the initialization flow by getting switch
> configuration, scheduler configuration and device capabilities.
> 
> Switch configuration:
> On boot, an L2 switch element is created in the firmware per physical
> function. Each physical function is also mapped to a port, to which its
> switch element is connected. In other words, this switch can be visualized
> as an embedded vSwitch that can connect a physical functions's virtual
> station interfaces (VSIs) to the egress/ingress port. Egress/ingress
> filters will be eventually created and applied on this switch element.
> As part of the initialization flow, the driver gets configuration data
> from this switch element and stores it.
> 
> Scheduler configuration:
> The Tx scheduler is a subsystem responsible for setting and enforcing QoS.
> As part of the initialization flow, the driver queries and stores the
> default scheduler configuration for the given physical function.
> 
> Device capabilities:
> As part of initialization, the driver has to determine what the device is
> capable of (ex. max queues, VSIs, etc). This information is obtained from
> the firmware and stored by the driver.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
> v2: Addressed Shannon Nelson's review comment by changing retry count value
>      to 2.

The fix looks fine.
sln

Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
