From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 20 Jul 2016 14:01:50 +0300
Subject: [Intel-wired-lan] [PATCH net] e1000e: fix PTP on e1000_pch_lpt
	variants
In-Reply-To: <1468959902-25071-1-git-send-email-jarod@redhat.com>
References: <1468959902-25071-1-git-send-email-jarod@redhat.com>
Message-ID: <347052e2-bca8-98b3-a35d-0f387b612e61@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello.

On 7/19/2016 11:25 PM, Jarod Wilson wrote:

> I've got reports that the Intel I-218V NIC in Intel NUC5i5RYH systems used
> as a PTP slave experiences random ~10 hour clock jumps, which are resolved
> if the same workaround for the 82574 and 82583 is employed. Switching from
> an if to a select, because the list of NIC types could well grow further

    s/select/switch/?

> and we'd already have to wrap the conditionals.
>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: intel-wired-lan at lists.osuosl.org
> CC: netdev at vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
[...]

MBR, Sergei


