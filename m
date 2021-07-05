From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 5 Jul 2021 12:22:16 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 01/12] ice: basic support
 for eswitch mode management
In-Reply-To: <YNKtdJjFpyiZG1YJ@localhost.localdomain>
References: <20210622212134.341728-1-michal.swiatkowski@linux.intel.com>
 <20210622212134.341728-2-michal.swiatkowski@linux.intel.com>
 <f1083357-9eb9-3bbb-baa5-0b4392ca4d4f@molgen.mpg.de>
 <YNKtdJjFpyiZG1YJ@localhost.localdomain>
Message-ID: <85e1e813-bb82-d2f4-6082-87205ab494a7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Michal,


Am 23.06.21 um 05:41 schrieb Michal Swiatkowski:
> On Wed, Jun 23, 2021 at 07:58:00AM +0200, Paul Menzel wrote:

>> Am 22.06.21 um 23:21 schrieb Michal Swiatkowski:

[?]

>>> - restore 'legacy' mode
>>> [root at localhost]# devlink dev eswitch set pci/0000:03:00.1 mode legacy
>>> [root at localhost]# devlink dev eswitch show pci/0000:03:00.1
>>>> pci/0000:03:00.1: mode legacy
>>
>> Thank you for adding these examples to the commit message. I?d put some of
>> them into the Kconfig description of `ICE_SWITCHDEV`.

> You mean putting this devlink command to help section of Kconfig?
> Something like:
> To go to E-switch mode type:
> devlink dev eswitch set pci/0000:03:00.1 mode switchdev
> 
> Is this right place for this kind of information? I have seen that
> Mellanox doesn't have command example in Kconfig for switchdev.

Indeed. There is 
`Documentation/networking/device_drivers/ethernet/mellanox/mlx5.rst`. As 
long as there is no documentation, I?d put it into the Kconfig 
description. If you add documentation, then just refer to that from the 
Kconfig description.


Kind regards,

Paul
