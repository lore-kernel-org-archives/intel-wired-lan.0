From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 16 Mar 2018 13:59:47 -0700
Subject: [Intel-wired-lan] [RFC PATCH 0/5] Enable XDP for ixgbevf
In-Reply-To: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
References: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
Message-ID: <98616fbe-e805-001d-0b00-f349334c69a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 02/26/2018 01:37 PM, Tony Nguyen wrote:
> This patch series implements support for XDP on ixgbevf;
> it is mainly based on the ixgbe implementation and supports
> the following actions: XDP_PASS, XDP_DROP, and XDP_TX.
> 
> Tony Nguyen (5):
>   ixgbevf: Add XDP support for pass and drop actions
>   ixgbevf: Add support for XDP_TX action
>   ixgbevf: Delay tail write for XDP packets
>   ixgbevf: Add support for meta data
>   ixgbevf: Add XDP queue stats reporting
> 

Series looks good to me. Feel free to add my ACK and
submit it proper.

.John
