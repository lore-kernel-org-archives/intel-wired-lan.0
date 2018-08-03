From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 3 Aug 2018 09:12:13 -0700
Subject: [Intel-wired-lan] IXGBE driver questions
In-Reply-To: <3A7E81AC661B4646A4CE6F2E09B7B74E05C6518C@HASMSX106.ger.corp.intel.com>
References: <CA+WKCcmYi+BeodZy_xdtWrjN05emwJ2Xhm5Lp0Y1tMS1E5kQow@mail.gmail.com>
 <da133a858c09b8c4192ae04149836f9a326552eb.camel@intel.com>
 <3A7E81AC661B4646A4CE6F2E09B7B74E05C6518C@HASMSX106.ger.corp.intel.com>
Message-ID: <f71f6532-b45a-dadd-2d3d-cfa589dfff48@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/3/2018 12:33 AM, Basierski, SebastianX wrote:

>>>
>>> 2) I found user-def instruction. But don't see how it work.
> Please check i40e driver documentation -> https://www.kernel.org/doc/Documentation/networking/i40e.txt
> There You can find a description of user-def.

Note that the question is regarding ixgbe, not i40e - the user-def is 
not the same between them.

The ixgbe driver uses the user-def field for filtering vlan-etype and 
doesn't have any option for retargeting the feature to a different set 
of packet bytes.

sln
