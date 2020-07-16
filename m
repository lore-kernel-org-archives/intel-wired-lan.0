From: Moritz Muehlenhoff <jmm@inutil.org>
Date: Thu, 16 Jul 2020 22:39:02 +0200
Subject: [Intel-wired-lan] Further information on
 CVE-2019-0145/CVE-2019-0146/CVE-2019-0147/CVE-2019-0148/CVE-2019-0149 for
 Linux?
Message-ID: <20200716203902.acn3ea2b4iorxlhq@inutil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,
https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00255.html refers
to vulnerabilities in Intel Ethernet drivers and a few of them refer to the i40e driver
specifically:

CVEID: CVE-2019-0145
Description: Buffer overflow in i40e driver for Intel(R) Ethernet 700 Series Controllers
versions before 7.0 may allow an authenticated user to potentially enable an escalation
of privilege via local access.

CVEID: CVE-2019-0146
Description: Resource leak in i40e driver for Intel(R) Ethernet 700 Series Controllers
versions before 2.8.43 may allow an authenticated user to potentially enable a denial of
service via local access.

CVEID: CVE-2019-0147
Description: Insufficient input validation in i40e driver for Intel(R) Ethernet 700 Series
Controllers versions before 7.0 may allow an authenticated user to potentially enable a
denial of service via local access.

CVEID: CVE-2019-0148
Description: Resource leak in i40e driver for Intel(R) Ethernet 700 Series Controllers
versions before 7.0 may allow an authenticated use to potentially enable a denial of
service via local access.

CVEID: CVE-2019-0149
Description: Insufficient input validation in i40e driver for Intel(R) Ethernet 700
Series Controllers versions before 2.8.43 may allow an authenticated user to potentially
enable a denial of service via local access.

Is there any further information which commits fixed these and if so, were they submitted
to stable kernels? (The Debian kernels are based on 4.9.x and 4.19.x LTS kernels, so that
we can make sure these are addressed in stable/oldstable releases)

Cheers,
        Moritz


