From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 26 Jan 2021 00:02:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 5/8] igc: Avoid TX Hangs
 because long cycles
In-Reply-To: <20210122224453.4161729-6-vinicius.gomes@intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-6-vinicius.gomes@intel.com>
Message-ID: <20210126000228.gpyh3rrp662wysit@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 22, 2021 at 02:44:50PM -0800, Vinicius Costa Gomes wrote:
> Avoid possible TX Hangs caused by using long Qbv cycles. In some
> cases, using long cycles (more than 1 second) can cause transmissions
> to be blocked for that time. As the TX Hang timeout is close to 1
> second, we may need to reduce the cycle time to something more
> reasonable: the value chosen is 1ms.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

Don't you want this patch to go to 'net' and be backported?
