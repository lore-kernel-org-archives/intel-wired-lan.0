From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 11 May 2021 11:01:26 -0600
Subject: [Intel-wired-lan] [PATCH 0/5] Fix some UTF-8 bad usages
In-Reply-To: <cover.1620744606.git.mchehab+huawei@kernel.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
Message-ID: <87fsytdx21.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series follow up this past series:
> 	https://lore.kernel.org/lkml/cover.1620641727.git.mchehab+huawei at kernel.org/
>
> Containing just the manual fixes from it. I'll respin the remaining
> patches on a separate series.
>
> Please note that patches 1 to 3 are identical to the ones posted
> on the original series.
>
> Patch 1 is special: it fixes some left-overs from a convertion
> from cdrom-standard.tex: there, some characters that are
> valid in C were converted to some visually similar UTF-8 by LaTeX.
>
> Patch 2 remove U+00ac (''): NOT SIGN characters at the end of
> the first line of two files. No idea why those ended being there :-p
>
> Patch 3 replaces:
> 	KernelVersion:3.3
> by:
> 	KernelVersion:	3.3
>
> which is the expected format for the KernelVersion field;
>
> Patches 4 and 5 fix some bad usages of EM DASH/EN DASH on
> places that it should be, instead, a normal hyphen. I suspect
> that they ended being there due to the usage of some conversion
> toolset.
>
> Mauro Carvalho Chehab (5):
>   docs: cdrom-standard.rst: get rid of uneeded UTF-8 chars
>   docs: ABI: remove a meaningless UTF-8 character
>   docs: ABI: remove some spurious characters
>   docs: hwmon: tmp103.rst: fix bad usage of UTF-8 chars
>   docs: networking: device_drivers: fix bad usage of UTF-8 chars
>
>  .../obsolete/sysfs-kernel-fadump_registered   |  2 +-
>  .../obsolete/sysfs-kernel-fadump_release_mem  |  2 +-
>  Documentation/ABI/testing/sysfs-module        |  4 +--
>  Documentation/cdrom/cdrom-standard.rst        | 30 +++++++++----------
>  Documentation/hwmon/tmp103.rst                |  4 +--
>  .../device_drivers/ethernet/intel/i40e.rst    |  4 +--
>  .../device_drivers/ethernet/intel/iavf.rst    |  2 +-
>  7 files changed, 24 insertions(+), 24 deletions(-)

These seem pretty straightforward; I've applied the set, thanks.

jon
