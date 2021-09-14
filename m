From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 14 Sep 2021 23:52:35 +0000
Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix displaying queue
 statistics shown by ethtool
In-Reply-To: <20210913073434.77748-1-jedrzej.jagielski@intel.com>
References: <20210913073434.77748-1-jedrzej.jagielski@intel.com>
Message-ID: <b4e1e8002f22d8b8dd9437841274a7e2d3c9ee49.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-09-13 at 07:34 +0000, Jedrzej Jagielski wrote:
> Driver provided too many lines as an output to ethtool -S command.
> Return actual length of string set of ethtool stats. Instead of
> predefined
> maximal value use the actual value on netdev, iterate over active
> queues.
> Without this patch, ethtool -S report would produce additional
> erroneous lines.
> 
> Without this change in statistics after showing them by ethtool -S
> will be displayed queues that are not configured.
> 
> Fixes: 6dba41cd02fc ("i40evf: update ethtool stats code and use
> helper functions")
> Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
> Signed-off-by: Przemyslaw Patynowski <
> przemyslawx.patynowski at intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---

Please include a changelog

>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 ++++++++++++-----
> --
>  1 file changed, 20 insertions(+), 11 deletions(-)

