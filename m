From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Aug 2016 09:01:33 -0700
Subject: [Intel-wired-lan] [next PATCH 1/5] i40e: Introduce devlink
	interface.
In-Reply-To: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
References: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <CAKgT0UeGtE2UUQWmjciz+zvLsCVPknvoUevmW6GRyDXMNCySSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 4, 2016 at 9:49 AM, Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:
> Add initial devlink support to set/get the mode of SRIOV switch.
> This patch allows the mode to be set to either 'legacy' or 'switchdev', but
> doesn't implement any functionality to create vf representors in switchdev
> mode.
>
> With smode support in iproute2 'devlink' utility, switch mode can be set
> and get via following commands.
>
>     # devlink dev smode pci/0000:05:00.0
>     mode: legacy
>     # devlink dev set pci/0000:05:00.0 smode switchdev
>     # devlink dev smode pci/0000:05:00.0
>     mode: switchdev
>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

I really don't see much value in this patch.  If you are going to
support SwitchDev then just do it.  Otherwise you are adding extra
overhead for maintaining two different modes.

I would recommend putting this series out to netdev as an RFC.
Submitting it to intel-wired-lan is kind of pointless as the audience
it to small to get any valuable review.

- Alex
