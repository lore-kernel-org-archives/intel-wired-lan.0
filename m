From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 2 Mar 2021 16:23:50 +0200
Subject: [Intel-wired-lan] [PATCH net-next v3 1/8] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <20210122224453.4161729-2-vinicius.gomes@intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-2-vinicius.gomes@intel.com>
Message-ID: <20210302142350.4tu3n4gay53cjnig@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

On Fri, Jan 22, 2021 at 02:44:46PM -0800, Vinicius Costa Gomes wrote:
> Frame preemption (described in IEEE 802.3br-2016) defines the concept
> of preemptible and express queues. It allows traffic from express
> queues to "interrupt" traffic from preemptible queues, which are
> "resumed" after the express traffic has finished transmitting.
> 
> Frame preemption can only be used when both the local device and the
> link partner support it.
> 
> Only parameters for enabling/disabling frame preemption and
> configuring the minimum fragment size are included here. Expressing
> which queues are marked as preemptible is left to mqprio/taprio, as
> having that information there should be easier on the user.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

I just noticed that the aMACMergeStatusVerify variable is not exposed in
the PREEMPT_GET command, which would allow the user to inspect the state
of the MAC merge sublayer verification state machine. Also, a way in the
PREEMPT_SET command to set the disableVerify variable would be nice.

Do you still have the iproute2 patch that goes along with this? If you
don't have the time, I might try to take a stab at adding these extra
parameters and resending.
