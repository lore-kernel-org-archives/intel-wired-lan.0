From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 24 Aug 2018 09:21:34 -0700
Subject: [Intel-wired-lan] ixgbe and packet steering
Message-ID: <c956c4e6-86bc-bda6-43a7-5cddac043f3c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi folks,

Is there any particular reason that ixgbe doesn't call 
skb_record_rx_queue()?  It looks like i40e, igb, and fm10k all call it, 
but I don't see it in ixgbe's flow.

sln

-- 
==================================================
Shannon Nelson           shannon.nelson at oracle.com
Parents can't afford to be squeamish
