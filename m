From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 27 Jun 2017 00:53:52 +0000
Subject: [Intel-wired-lan] [PATCH] igb: protect TX timestamping from
	API	misuse
In-Reply-To: <20170619203043.120598-1-cspradlin@google.com>
References: <20170619203043.120598-1-cspradlin@google.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6251C5@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Cliff Spradlin
> Sent: Monday, June 19, 2017 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: protect TX timestamping from API
> misuse
> 
> HW timestamping can only be requested for a packet if the NIC is first
> setup via ioctl(SIOCSHWTSTAMP). If this step was skipped, then the igb
> driver still allowed TX packets to request HW timestamping. In this
> situation, the _IGB_PTP_TX_IN_PROGRESS flag was set and would never
> clear. This prevented any future HW timestamping requests to succeed.
> 
> Fix this by checking that the NIC is configured for HW TX timestamping
> before accepting a HW TX timestamping request.
> 
> Signed-off-by: Cliff Spradlin <cspradlin@google.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
