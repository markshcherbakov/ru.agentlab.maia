package ru.agentlab.maia.memory.context.test.suite

import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Suite.SuiteClasses
import ru.agentlab.maia.memory.context.test.AbstractContext_removeByClass_FunctionalTests
import ru.agentlab.maia.memory.context.test.AbstractContext_removeByString_FunctionalTests
import ru.agentlab.maia.memory.context.test.AbstractContext_putServiceByString_FunctionalTests
import ru.agentlab.maia.memory.context.test.AbstractContext_putServiceByClass_FunctionalTests

@RunWith(Parameterized)
@SuiteClasses(#[
	AbstractContext_removeByClass_FunctionalTests,
	AbstractContext_removeByString_FunctionalTests,
	AbstractContext_putServiceByClass_FunctionalTests,
	AbstractContext_putServiceByString_FunctionalTests
])
abstract class AbstractContext_FunctionalTestSuite {
}