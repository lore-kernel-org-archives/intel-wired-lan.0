From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Wed, 6 Feb 2019 09:56:45 -0800
Subject: [Intel-wired-lan] [PATCH v3] i40e: Add macvlan support on i40e
In-Reply-To: <20190116235414.4946-1-harshitha.ramamurthy@intel.com>
References: <20190116235414.4946-1-harshitha.ramamurthy@intel.com>
Message-ID: <CAP-MU4NfttNwuMctDJenco=3eZJZtoSK7T8Z_do7+8Lvx9htQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 16, 2019 at 3:54 PM Harshitha Ramamurthy
<harshitha.ramamurthy@intel.com> wrote:
>
> This patch enables macvlan offloads for i40e. The idea is to use
> channels as macvlan interfaces. The channels are VSIs of
> type VMDQ. When the first macvlan is created, the maximum number of
> channels possible are created. From then on, as a macvlan interface
> is created, a mac filter is added to these already created channels
> (VSIs).
>
> This patch builds on top of the recent changes which move
> away from the select_queue implementation of picking the tx queue.
>
> Steps to configure macvlan offloads:
> 1. sudo ethtool -K ens261f1 l2-fwd-offload on
> 2. ip link add link ens261f1 name macvlan1 type macvlan
> 3. sudo ip link add link ens261f1 name macvlan1 type macvlan
> 4. sudo ip link set macvlan1 up
>
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

Hi Harshitha, thanks for your patience, I've had a challenging couple of weeks.

The only heartburn I have at this point is the hard-coded numbers in
fwd_add when working out how many queues to set aside for macvlan
offloads.  I'd rather see those as fractions of a constant, where that
constant might change for different i40e devices.  However, I realize
the xl7xx family probably won't change there, so it will probably be
fine.

Ack-by: Shannon Nelson <shannon.lee.nelson@gmail.com>

Cheers,
sln
